//
//  TZViewController.m
//  Performance004
//
//  Created by hzg on 2018/9/21.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "TZViewController.h"
#import "TimerWrapper.h"

@interface TZViewController ()
//@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) TimerWrapper* timer;

@end

@implementation TZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    /// RunLoop -> timer -> target --> self
    self.timer = [[TimerWrapper alloc] initWithTimerInterval:1.0 target:self selector:@selector(fire)];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fire) userInfo:nil repeats:YES];
}


//- (void) didMoveToParentViewController:(UIViewController *)parent {
//    if (nil == parent) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//}


- (void) fire {
    NSLog(@"%s", __func__);
}

- (void)dealloc
{
    [self.timer stop];
    NSLog(@"%s", __func__);
}



@end
