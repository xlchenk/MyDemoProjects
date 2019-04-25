//
//  GtestDemo01UITests.m
//  GtestDemo01UITests
//
//  Created by chenxl on 2019/4/4.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface GtestDemo01UITests : XCTestCase

@end

@implementation GtestDemo01UITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testLogin{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *element = [[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"login"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
    
    // TF
    XCUIElementQuery *tfQuery = [element childrenMatchingType:XCUIElementTypeTextField];
    XCUIElement *accountTF = [tfQuery elementBoundByIndex:0];
    XCUIElement *passwordTF = [tfQuery elementBoundByIndex:1];
    
    // button
    XCUIElementQuery *buttonQuery = [element childrenMatchingType:XCUIElementTypeButton];
    XCUIElement *loginBtn = [buttonQuery elementBoundByIndex:0];
    
    // 键盘
    XCUIElement *delete = app.keys[@"delete"];
    
    // UI操作
    [accountTF tap];
    [accountTF typeText:@"123456"];
    [passwordTF tap];
    [passwordTF typeText:@"12345"];
    [loginBtn tap];
    [passwordTF tap];
    [delete doubleTap];
    [loginBtn tap];
    
    
}
- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
