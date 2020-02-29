//
//  TZSecondViewController.m
//  KVO001
//
//  Created by hzg on 2018/9/17.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "TZSecondViewController.h"
#import "TZPerson.h"
#import <objc/runtime.h>

@interface TZSecondViewController ()
@property (nonatomic, strong) TZPerson* p;
@end

@implementation TZSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _p = [TZPerson new];
    
    Class class = NSClassFromString(@"NSKVONotifying_TZPerson");
    if (class) {
        NSLog(@"class exist");
    } else {
        NSLog(@"class not exist");
    }
    
//    /// 添加观察者
    [_p addObserver:self forKeyPath:@"steps" options:NSKeyValueObservingOptionPrior | NSKeyValueObservingOptionNew context:nil];
    
    
    Class class1 = NSClassFromString(@"NSKVONotifying_TZPerson");
    if (class1) {
        NSLog(@"class1 exist");
    } else {
        NSLog(@"class1 not exist");
    }
    
    [self printMethods:class1];
    [self printClasses:[TZPerson class]];
}

/// 打印对应的类及子类
- (void) printClasses:(Class) cls {
    
    /// 注册类的总数
    int count = objc_getClassList(NULL, 0);
    
    /// 创建一个数组， 其中包含给定对象
    NSMutableArray* array = [NSMutableArray arrayWithObject:cls];
    
    /// 获取所有已注册的类
    Class* classes = (Class*)malloc(sizeof(Class)*count);
    objc_getClassList(classes, count);
    
    /// 遍历s
    for (int i = 0; i < count; i++) {
        if (cls == class_getSuperclass(classes[i])) {
            [array addObject:classes[i]];
        }
    }
    
    free(classes);
    
    NSLog(@"classes = %@", array);
}

- (void) printMethods:(Class)cls {
    unsigned int count = 0;
    Method* methods = class_copyMethodList(cls, &count);
    
    NSMutableArray* array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        IMP imp = method_getImplementation(method);
        NSString* methodName = NSStringFromSelector(sel);
        [array addObject:methodName];
    }
    NSLog(@"%@", array);
    free(methods);
}


// 实现监听方法
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
}


/**
 NSKeyValueWillChange
 [TZPerson setSteps:]
 NSKeyValueDidChange
 NSKeyValueNotifyObserver
 - (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _p.steps++;// setter getter
} 

/*
 - (Class) class {
 
 return object_superClass(object_getClass(self));
 }
 
 
 */

- (void) dealloc {
    [_p removeObserver:self forKeyPath:@"steps"];
    NSLog(@"");
}



@end
