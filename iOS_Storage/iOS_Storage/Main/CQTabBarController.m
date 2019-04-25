//
//  CQTabBarController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/2.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQTabBarController.h"
#import "CQContentViewController.h"

@interface CQTabBarController ()

@end

@implementation CQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CQContentViewController *demoVC = [[CQContentViewController alloc] initWithContent:@"demo_contents"];
    UINavigationController *demoNavi = [[UINavigationController alloc] initWithRootViewController:demoVC];
    demoVC.title = demoNavi.tabBarItem.title = @"demo";
    
    CQContentViewController *architectureVC = [[CQContentViewController alloc] initWithContent:@"architecture_contents"];
    UINavigationController *architectureNavi = [[UINavigationController alloc] initWithRootViewController:architectureVC];
    architectureVC.title = architectureNavi.tabBarItem.title = @"架构/设计模式";
    
    CQContentViewController *libraryVC = [[CQContentViewController alloc] initWithContent:@"library_contents"];
    UINavigationController *libraryNavi = [[UINavigationController alloc] initWithRootViewController:libraryVC];
    libraryVC.title = libraryNavi.tabBarItem.title = @"框架";
    
    CQContentViewController *arithmeticVC = [[CQContentViewController alloc] initWithContent:@"arithmetic_contents"];
    UINavigationController *arithmeticNavi = [[UINavigationController alloc] initWithRootViewController:arithmeticVC];
    arithmeticVC.title = arithmeticNavi.tabBarItem.title = @"算法/数据结构";
    
    CQContentViewController *interviewVC = [[CQContentViewController alloc] initWithContent:@"tips_contents"];
    UINavigationController *interviewNavi = [[UINavigationController alloc] initWithRootViewController:interviewVC];
    interviewVC.title = interviewNavi.tabBarItem.title = @"tips";
    
    self.viewControllers = @[demoNavi, architectureNavi, libraryNavi, arithmeticNavi, interviewNavi];
}

@end
