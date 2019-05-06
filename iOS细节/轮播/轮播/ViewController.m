//
//  ViewController.m
//  轮播
//
//  Created by chenxl on 2019/4/29.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"
 
#import "CLLoopView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface ViewController ()
@property(nonatomic,strong) CLLoopView * cycle ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _cycle = [[CLLoopView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200)];
 
    _cycle.imageArray = @[@"home_banner01",@"home_banner02",@"home_banner03",@"home_banner04"];
    [self.view addSubview:_cycle];
    _cycle.callBackBannerClick = ^(NSInteger index) {
        NSLog(@"点击回掉参数%ld",index);
    };
}


@end
