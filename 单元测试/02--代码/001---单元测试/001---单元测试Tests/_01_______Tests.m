//
//  _01_______Tests.m
//  001---单元测试Tests
//
//  Created by Cooci on 2018/7/3.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <XCTest/XCTest.h>

//

//
@interface _01_______Tests : XCTestCase

@end


@implementation _01_______Tests

// 执行顺序
- (void)setUp {
    [super setUp];
    NSLog(@"初始化");
}

- (void)tearDown {
    [super tearDown];
    
    NSLog(@"销毁清除");
}

- (void)testExample {

    NSLog(@"电/静");
}

- (void)testPerformanceExample {
    
    NSLog(@"性能测试");

    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
