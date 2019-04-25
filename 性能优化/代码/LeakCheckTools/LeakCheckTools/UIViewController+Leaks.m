//
//  UIViewController+Leaks.m
//  LeakCheckTools
//
//  Created by hzg on 2018/5/17.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "UIViewController+Leaks.h"
#import "NSObject+Leaks.h"
#import <objc/runtime.h>


/**
 
 目标：监听UIViewController类是否发生内存泄漏（这里只考虑push,pop的情况）
 
 思路：我们在视图控制器弹出栈，并在这个视图完全消失的时候，监听对象是否还还活着。
 
 步骤：
 1）交换视图控制器的viewWillAppear与swizzled_viewWillAppear方法，viewDidDisappear与swizzled_viewDidDisappear方法
 2）使用关联方法，获取和设置视图控制进出栈状态
 3）且在界面完全消失，并控制器的状态是出栈状态，这时，观察延时观察对象是否存活
 
 */



@implementation UIViewController (Leaks)

const void* const kHasBeenPoppedKey = &kHasBeenPoppedKey;//"kHasBeenPoppedKey";

+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(viewWillAppear:) withSEL:@selector(tz_viewWillAppear:)];
        [self swizzleSEL:@selector(viewDidDisappear:) withSEL:@selector(tz_viewDidDisappear:)];
    });
}


- (void) tz_viewWillAppear:(BOOL) animated {
    [self tz_viewWillAppear:animated];
    
    objc_setAssociatedObject(self, kHasBeenPoppedKey, @(NO), OBJC_ASSOCIATION_RETAIN);
}

- (void) tz_viewDidDisappear:(BOOL) animated {
    [self tz_viewDidDisappear:animated];
    
    if ([objc_getAssociatedObject(self, kHasBeenPoppedKey) boolValue]) {
        [self willDealloc];
    }
}


@end
