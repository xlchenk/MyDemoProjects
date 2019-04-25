//
//  NSObject+KVO.m
//  002-KVO的实现原理
//
//  Created by hzg on 2018/7/29.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/message.h>


static const char* kTZKVOAssiociateKey = "kTZKVOAssiociateKey";

@interface TZInfo : NSObject

@property (nonatomic, weak) NSObject* observer;
@property (nonatomic, strong) NSString* keyPath;
@property (nonatomic, copy) TZKVOBlock hanleBlock;

@end


@implementation TZInfo

- (instancetype) initWithObserver:(NSObject*)observer forKeyPath:(NSString*) keyPath handleBlock:(TZKVOBlock) block {
    if (self == [super init]) {
        _observer = observer;
        _keyPath = keyPath;
        _hanleBlock = block;
    }
    return self;
}

@end


@implementation NSObject (KVO)

//+ (void) load {
//    // NSObject dealloc
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method m1 = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
//        Method m2 = class_getInstanceMethod(self, @selector(myDealloc));
//        method_exchangeImplementations(m1, m2);
//    });
//}
//

- (void) tz_addObserverBlock:(NSObject*) observer forKeyPath:(NSString*) keyPath handle:(TZKVOBlock) handleBlock {
    
    // 动态创建一个子类
    Class newClass = [self createClass:keyPath];
    
    // 修改了isa的指向
    object_setClass(self, newClass);
    
    // 信息保存
    TZInfo* info = [[TZInfo alloc] initWithObserver:observer forKeyPath:keyPath handleBlock:handleBlock];
    NSMutableArray* array = objc_getAssociatedObject(self, kTZKVOAssiociateKey);
    if (!array) {
        array = [NSMutableArray array];
        objc_setAssociatedObject(self, kTZKVOAssiociateKey, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [array addObject:info];
}

/// 添加观察者
- (void)gv_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    
    // 动态创建一个子类
    Class newClass = [self createClass:keyPath];
    
    // 修改了isa的指向
    object_setClass(self, newClass);
    
    // 关联方法
    objc_setAssociatedObject(self, (__bridge void *)@"objc", observer, OBJC_ASSOCIATION_ASSIGN);
}

// NSKVONotifying_TZPerson
- (Class) createClass:(NSString*) keyPath {
   
    // 1. 拼接子类名 // Person
    NSString* oldName = NSStringFromClass([self class]);
    NSString* newName = [NSString stringWithFormat:@"TZKVONotifying_%@", oldName];
    
    // 2. 创建并注册类
    Class newClass = NSClassFromString(newName);
    if (!newClass) {
        
        // 创建并注册类
        newClass = objc_allocateClassPair([self class], newName.UTF8String, 0);
        objc_registerClassPair(newClass);
        
        // 添加一些方法
        // class
        Method classMethod = class_getInstanceMethod([self class], @selector(class));
        const char* classTypes = method_getTypeEncoding(classMethod);
        class_addMethod(newClass, @selector(class), (IMP)tz_class, classTypes);
        
        // setter
        NSString* setterMethodName = setterForGetter(keyPath);
        SEL setterSEL = NSSelectorFromString(setterMethodName);
        Method setterMethod = class_getInstanceMethod([self class], setterSEL);
        const char* setterTypes = method_getTypeEncoding(setterMethod);
        
        class_addMethod(newClass, setterSEL, (IMP)tz_setter, setterTypes);
        
        // 添加析构方法
        SEL deallocSEL = NSSelectorFromString(@"dealloc");
        Method deallocMethod = class_getInstanceMethod([self class], deallocSEL);
        const char* deallocTypes = method_getTypeEncoding(deallocMethod);
        class_addMethod(newClass, deallocSEL, (IMP)myDealloc, deallocTypes);
        
        
        // hook dealloc
       // [self hookDealloc];
    }
    return newClass;
}

void myDealloc(id self, SEL _cmd) {
    // 父类
    Class superClass = [self class];//class_getSuperclass(object_getClass(self));
    
    object_setClass(self, superClass);
    
    NSLog(@"");
}

//- (void) myDealloc {
//
//        // 父类
//    Class superClass = [self class];//class_getSuperclass(object_getClass(self));
//
//    object_setClass(self, superClass);
//
//    [self myDealloc];
//}

- (void) hookDealloc {
    Method m1 = class_getInstanceMethod(object_getClass(self), NSSelectorFromString(@"dealloc"));
    Method m2 = class_getInstanceMethod(object_getClass(self), @selector(myDealloc));
    method_exchangeImplementations(m1, m2);
}

#pragma mark - c 函数
static void tz_setter(id self, SEL _cmd, id newValue) {
    NSLog(@"%s", __func__);
    
    struct objc_super superStruct = {
        self,
        class_getSuperclass(object_getClass(self))
    };
    
    // keypath
       NSString* keyPath = getterForSetter(NSStringFromSelector(_cmd));
    
    // 获取旧值
    // kVC
    id oldValue = objc_msgSendSuper(&superStruct, NSSelectorFromString(keyPath));
    
    // 改变父类的值
    objc_msgSendSuper(&superStruct, _cmd, newValue);
    
    NSMutableArray* array = objc_getAssociatedObject(self, kTZKVOAssiociateKey);
    if (array) {
        for (TZInfo* info in array) {
            if ([info.keyPath isEqualToString:keyPath]) {
                info.hanleBlock(info.observer, keyPath, oldValue, newValue);
                return;
            }
        }
    }
    
//    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:), key, self, @{key:newValue}, nil);
}


Class tz_class(id self, SEL _cmd) {
    return class_getSuperclass(object_getClass(self));
}


///// 移除观察者
//- (void)gv_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
//
//    // 父类
//    Class superClass = [self class];//class_getSuperclass(object_getClass(self));
//
//    object_setClass(self, superClass);
//
//}


#pragma mark - 从get方法获取set方法的名称 key ===>>> setKey:
static NSString  * setterForGetter(NSString *getter){
    
    if (getter.length <= 0) { return nil; }
    
    NSString *firstString = [[getter substringToIndex:1] uppercaseString];
    NSString *leaveString = [getter substringFromIndex:1];
    
    return [NSString stringWithFormat:@"set%@%@:",firstString,leaveString];
}

#pragma mark - 从set方法获取getter方法的名称 set<Key>:===> Key
static NSString * getterForSetter(NSString *setter){
    
    if (setter.length <= 0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) { return nil;}
    
    NSRange range = NSMakeRange(3, setter.length-4);
    NSString *getter = [setter substringWithRange:range];
    NSString *firstString = [[getter substringToIndex:1] lowercaseString];
    getter = [getter stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstString];
    
    return getter;
}

@end
