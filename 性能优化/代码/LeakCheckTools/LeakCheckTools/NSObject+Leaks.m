//
//  NSObject+Leaks.m
//  LeakCheckTools
//
//  Created by hzg on 2018/5/17.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "NSObject+Leaks.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation NSObject (Leaks)


/**
 简单的做个小结：
 
 1、在使用block时，如果block内部需要访问self的方法、属性、或者实例变量应当使用weakSelf
 2、如果在block内需要多次访问self，则需要使用strongSelf
 3、如果在block内部存在多线程环境访问self，则需要使用strongSelf
 4、block本身不存在多线程之分，block执行是否是多线程，取决于当前的持有者是否是以多线程的方式来调用它。
 
 */
- (void)willDealloc {
    
    __weak id weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong id strongSelf = weakSelf;
        [strongSelf assertNotDealloc];
    });
    
}

- (void) assertNotDealloc {
    NSLog(@"Leaks %@", NSStringFromClass([self class]));
}

+ (void) swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL {
   
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
