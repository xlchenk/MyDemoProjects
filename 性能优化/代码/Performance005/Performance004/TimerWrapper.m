//
//  TimerWrapper.m
//  Performance004
//
//  Created by hzg on 2018/9/21.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "TimerWrapper.h"

@interface TimerWrapper()

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL sel;
@property (nonatomic, strong) NSTimer* timer;

@end

@implementation TimerWrapper

- (id) initWithTimerInterval:(NSTimeInterval)interval target:(id)target selector:(SEL) sel {
    if (self = [super init]) {
        self.target = target;
        self.sel = sel;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fire) userInfo:nil repeats:YES];
    }
    return self;
}

- (void) fire {
    if ([self.target respondsToSelector:self.sel]) {
        [self.target performSelector:self.sel];
    }
}

- (void) stop {
    [self.timer invalidate];
    self.timer = nil;
}

@end
