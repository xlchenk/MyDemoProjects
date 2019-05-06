//
//  SecondController.m
//  轮播
//
//  Created by chenxl on 2019/5/6.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "SecondController.h"
#import "ViewController.h"
@interface SecondController ()

@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}
 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}


@end
