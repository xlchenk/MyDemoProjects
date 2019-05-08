//
//  ViewController.m
//  CLLoopViewDemo
//
//  Created by chenxl on 2019/5/8.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"
#import "CLLoopView/CLLoopView.h"
#define SCREEN_WHDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CLLoopView * loopView = [[CLLoopView alloc]initWithFrame:CGRectMake(0, 100,SCREEN_WHDTH , 200)];
    loopView.imageArray = @[@"banner01",@"banner02",@"banner03",@"banner04"];
    loopView.bannerClickCallBack = ^(NSInteger index) {
        NSLog(@"下标%ld",index);
    };
    [self.view addSubview:loopView];
}


@end
