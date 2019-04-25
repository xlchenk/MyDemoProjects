//
//  VCTest.m
//  001---单元测试Tests
//
//  Created by chenxl on 2019/4/3.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
@interface VCTest : XCTestCase
@property(nonatomic,strong) ViewController * vc;
@end

@implementation VCTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [[ViewController alloc]init];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
