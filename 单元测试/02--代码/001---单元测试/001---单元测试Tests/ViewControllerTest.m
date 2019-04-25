//
//  ViewControllerTest.m
//  001---单元测试Tests
//
//  Created by cooci on 2018/9/26.
//  Copyright © 2018 Cooci. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface ViewControllerTest : XCTestCase
@property (nonatomic, strong) ViewController *vc;

@end

@implementation ViewControllerTest

- (void)setUp {

    self.vc = [ViewController new];
    
}

- (void)tearDown {

    self.vc = nil;
    // dealloc
    
}

// 逻辑
// 性能
// 异步
// 目的性:  内部方法 走通 稳定 异步


- (void)testGetplus{
    
    // a三步骤
    // give
    int a = 10;
    int b = 20;
    
    // when --- 断言
    // 调d接口
    int c = [self.vc getPlus:a num2:b];
    
    // then
    XCTAssertEqual(c, 30,@"我哭了");

    [self getplus];
    // 黑盒测试 : 线 --- 产品
}

// 工具
- (void)getplus{
    // 订单测试
    // 测试驱动代码 魔性
    // 接口 --- 写逻辑
    // 1 : 订单号: 异步性测试
    // 2 : 集成 : 成功
    // 3 : 后台
    // 4 : 页面
    
    NSLog(@"123");
    // 内部方法
}

// x程序c性能 ---> 方法 ---> a耗时
// 二维码
// 相册 : image (layer) , iclound : qq

- (void)testPerformanceExampleTwo {
    // This is an example of a performance test case.
    [self measureMetrics:@[XCTPerformanceMetric_WallClockTime] automaticallyStartMeasuring:NO forBlock:^{
        
        // 0.248 * 2
        // 支付 回调
        [self.vc openCamera];

        // 自己服务器
        [self startMeasuring];
        [self.vc openCamera];
        [self stopMeasuring];
        
    }];
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    
    // 模拟器 mac iphon6 7 8 x
    [self measureBlock:^{
        
        [self.vc openCamera];
    }];
}


#pragma mark - 异步测试

- (void)testAsy{
    
    
    // 首页 --- 还不回来
    // 产品 --- 后台 前台 app 用户体验
    // 效率
    // 压力测试 ---
    
    // given
    // 时间
    XCTestExpectation *exc = [self expectationWithDescription:@"这是我的期望"];
    
    // when
    [self.vc loadData:^(id data) {
        // 夹 逻辑
        XCTAssertNotNil(data,@"返回o空了");
        
        [exc fulfill];
    }];
    
    //then
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        NSLog(@"你快回来");
    }];
    
}

@end
