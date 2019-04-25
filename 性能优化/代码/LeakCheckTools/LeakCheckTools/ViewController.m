//
//  ViewController.m
//  LeakCheckTools
//
//  Created by hzg on 2018/5/17.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>

@interface ViewController ()

@end

@implementation ViewController

+ (void)load {
    NSLog(@"hello");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPushButtonClicked:(UIButton *)sender {
    UIViewController* vc =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeaksVC"];
    [self.navigationController pushViewController:vc animated:true];
}

@end
