//
//  ViewController.m
//  LLCycleScrollViewDemo
//
//  Created by chenxl on 2019/5/7.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"
#import "LLCycleScrollView/LLCycleScrollView.h"

#define SCREEN_WHDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LLCycleScrollView * scroll = [[LLCycleScrollView alloc]initWithFrame:CGRectMake(0, 100,SCREEN_WHDTH , 200)];
    scroll.imageArray =@[@"banner01",@"banner02",@"banner03",@"banner04"];
    scroll.backgroundColor = [UIColor redColor];
    [self.view addSubview:scroll];
    
}


@end
