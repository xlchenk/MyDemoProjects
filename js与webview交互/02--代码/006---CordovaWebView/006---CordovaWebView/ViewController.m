//
//  ViewController.m
//  006---CordovaWebView
//
//  Created by Cooci on 2018/7/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
//    self.startPage = @"http://www.baidu.com";

    [super viewDidLoad];
  
    self.webView.frame = CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 20);
}

- (IBAction)didClickRightAction:(id)sender {
    NSLog(@"didClickRightAction");
    NSString *jsStr = @"cordovaButton('哈哈啊哈')";
    [self.commandDelegate evalJs:jsStr];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
