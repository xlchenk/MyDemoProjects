//
//  ViewController.m
//  002---UITestDemo
//
//  Created by Cooci on 2018/4/24.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"
#import "LoginSuccessfulViewController.h"
#import "KC_View.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *customBtn;
@property (nonatomic, strong) KC_TextField *customTF;
@property (nonatomic, strong) KC_View *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self.view addSubview:self.customBtn];
//    [self.view addSubview:self.customTF];
//    [self.view addSubview:self.customView];
}

- (void)didClickCustomBtn:(UIButton *)sender{
    
    [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor grayColor];
    if (self.customTF.text.length>0) {
        [self.customBtn setTitle:self.customTF.text forState:UIControlStateNormal];
    }
}

- (IBAction)Login:(UIButton *)sender {
    if ([self isVerifySuccess]) {
        LoginSuccessfulViewController *loginSsVc = [LoginSuccessfulViewController new];
        loginSsVc.navigationItem.title=@"loginSuccessView";
        UILabel *successLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 90, 200, 80)];
        successLabel.text = @"登录成功";
        successLabel.textAlignment = NSTextAlignmentJustified;
        [loginSsVc.view addSubview:successLabel];
        loginSsVc.view.backgroundColor = [UIColor greenColor];
        [self.navigationController pushViewController:loginSsVc animated:YES];
        
    } else {
        self.passwordTextField.backgroundColor = [UIColor redColor];
    }
}

- (BOOL)isVerifySuccess {
    if ([self.accountTextField.text isEqualToString:@"123456"] && [self.passwordTextField.text isEqualToString: @"123"]) {
        return YES;
    }
    return NO;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - lazy

- (UIButton *)customBtn{
    if (!_customBtn) {
        
        _customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _customBtn.frame = CGRectMake(80, 220, 200, 30);
        [_customBtn setTitle:@"自定义的按钮" forState:UIControlStateNormal];
        [_customBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _customBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_customBtn addTarget:self action:@selector(didClickCustomBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customBtn;
}

- (KC_TextField *)customTF{
    if (!_customTF) {
        _customTF = [[KC_TextField alloc] initWithFrame:CGRectMake(70, 270, 200, 30)];
        _customTF.borderStyle = UITextBorderStyleRoundedRect;
        _customTF.layer.borderWidth = 1;
        _customTF.layer.borderColor = [UIColor orangeColor].CGColor;
        _customTF.placeholder = @"子类:请输入";
    }
    return _customTF;
}

- (KC_View *)customView{
    if (!_customView) {
        _customView = [[KC_View alloc] initWithFrame:CGRectMake(70, 350, 200, 30)];
    }
    return _customView;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
