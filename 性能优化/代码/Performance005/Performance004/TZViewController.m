//
//  TZViewController.m
//  Performance004
//
//  Created by hzg on 2018/9/21.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "TZViewController.h"
#import "TimerWrapper.h"
#import <objc/runtime.h>
#import "TZWeakProxy.h"

@interface TZViewController ()

//@property (nonatomic, strong) id target;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) TZWeakProxy* proxy;


@end

@implementation TZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    /// RunLoop -> timer -> target ---> self
//    self.target = [NSObject new];
//    class_addMethod([self.target class], @selector(fire), (IMP)fire, "v@:");
    
    self.proxy = [TZWeakProxy alloc];
    self.proxy.target = self;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self.proxy selector:@selector(fire) userInfo:nil repeats:YES];
}

//void fire()  {
//    NSLog(@"%s", __func__);
//}

- (void) fire {
    NSLog(@"%s", __func__);
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"%s", __func__);
}



@end
