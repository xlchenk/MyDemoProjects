//
//  ViewController.m
//  LLCycleViewDemo
//
//  Created by chenxl on 2019/5/7.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"
#import "LLCycleView/LLCycleView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface ViewController ()
@property(nonatomic,strong) LLCycleView * cycle ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _cycle = [[LLCycleView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200)];
    _cycle.imageArray = @[@"banner01",@"banner02",@"banner03",@"banner04"];
    [self.view addSubview:_cycle];
    _cycle.callBackBannerClick = ^(NSInteger index) {
        NSLog(@"点击回掉参数%ld",index);
    };
   
}


@end
