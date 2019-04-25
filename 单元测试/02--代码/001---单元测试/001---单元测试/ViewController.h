//
//  ViewController.h
//  001---单元测试
//
//  Created by Cooci on 2018/7/3.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// 单元测试 :  核心代码 稳定性 --- 主要功能类 , sdk
// 接口请求很复杂 , 支付 : id ---> 订单号  --- 支付 ---> 回调 ---> 确认  ----> 成功
// 中间砍 (自己服务器) --- 假的数据 -- 订单 --->
// 因子 ---> 测试 ---> 单一变量原则

- (int)getPlus:(int)num1 num2:(int)num2;

- (void)loadData:(void (^)(id data))dataBlock;

- (void)openCamera;

@end

