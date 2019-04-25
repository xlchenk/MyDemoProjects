//
//  TZWeakProxy.m
//  Performance004
//
//  Created by hzg on 2018/9/21.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "TZWeakProxy.h"

@implementation TZWeakProxy

- (NSMethodSignature*) methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void) forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
