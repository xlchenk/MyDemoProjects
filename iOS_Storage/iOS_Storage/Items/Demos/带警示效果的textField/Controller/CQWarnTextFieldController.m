//
//  CQWarnTextFieldController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/29.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQWarnTextFieldController.h"
#import "CQWarnTextField.h"

@interface CQWarnTextFieldController ()

@property (nonatomic, strong) CQWarnTextField *textField;

@end

@implementation CQWarnTextFieldController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建一个warnTextField
    self.textField = [[CQWarnTextField alloc]initWithFrame:CGRectMake(60, 200, 200, 30)];
    self.textField.placeholder = @"请输入用户名";
    [self.view addSubview:self.textField];
    [self.textField becomeFirstResponder];
    
    // 创建一个button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, 260, 100, 30);
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(showWarn) forControlEvents:UIControlEventTouchUpInside];
}

// 文本框警示
- (void)showWarn {
    [self.textField showWarn];
}

@end
