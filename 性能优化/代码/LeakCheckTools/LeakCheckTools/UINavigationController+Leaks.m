//
//  UINavigationController+Leaks.m
//  LeakCheckTools
//
//  Created by hzg on 2018/5/17.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "UINavigationController+Leaks.h"
#import "NSObject+Leaks.h"
#import <objc/runtime.h>

@implementation UINavigationController (Leaks)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(popViewControllerAnimated:) withSEL:@selector(tz_popViewControllerAnimated:)];
    });
}

- (UIViewController*) tz_popViewControllerAnimated:(BOOL) animated {
    UIViewController* popViewController = [self tz_popViewControllerAnimated:animated];
    
    extern const void* const kHasBeenPoppedKey;
    objc_setAssociatedObject(popViewController, kHasBeenPoppedKey, @(YES), OBJC_ASSOCIATION_RETAIN);
    
    return popViewController;
}

@end
