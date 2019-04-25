//
//  CQSimpleFactoryViewController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/9/11.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQSimpleFactoryViewController.h"
#import "CQCarFactory.h"

@interface CQSimpleFactoryViewController ()

@end

@implementation CQSimpleFactoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD showInfoWithStatus:@"注意控制台"];
    
    // 要生产的car的类型
    NSArray *typeArray = @[@(CQCarTypeBenz), @(CQCarTypeBMW), @(CQCarTypeBenz)];
    
    for (int i = 0; i < typeArray.count; i++) {
        CQCarType carType = [typeArray[i] integerValue];
        // 传入type，创建car
        CQCar *car = [CQCarFactory produceCarWithType:carType];
        // 打印car的信息
        [car printInfo];
    }
}



@end
