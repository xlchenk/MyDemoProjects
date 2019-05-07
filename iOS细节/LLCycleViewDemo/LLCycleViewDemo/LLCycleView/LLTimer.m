//
//  LLTimer.m
//  LLCycleViewDemo
//
//  Created by chenxl on 2019/5/7.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "LLTimer.h"

@interface LLTimer ()
@property(nonatomic,weak)id target;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign) SEL sel;
@end

@implementation LLTimer
- (instancetype)initWithTimerInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector{
    
    if (self = [super init]) {
        self.target = target;
        self.sel = selector;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(fire) userInfo:nil repeats:YES];
    }
    return self;
}


- (void)fire{
    if ([self.target respondsToSelector:self.sel]) {
        [self.target performSelector:self.sel];
    }
}

- (void)stop{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    
    [self stop];
}
@end
