//
//  NSObject+Leaks.h
//  LeakCheckTools
//
//  Created by hzg on 2018/5/17.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Leaks)

- (void)willDealloc;

+ (void) swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;

@end
