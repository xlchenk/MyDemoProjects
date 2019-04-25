//
//  OCMOCK01UITests.m
//  OCMOCK01UITests
//
//  Created by chenxl on 2019/4/3.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface OCMOCK01UITests : XCTestCase

@end

@implementation OCMOCK01UITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
/** 继承自XCUIElement 表示 各种UI元素
 exist
 可以让你判断当前的 UI 元素是否存在，如果对一个不存在的元素进行操作，会导致测试组件抛出异常并中断测试
 4、descendantsMatchingType(type:XCUIElementType)->XCUIElementQuery:
 取某种类型的元素以及它的子类集合
 childrenMatchingType(type:XCUIElementType)->XCUIElementQuery:
 取某种类型的元素集合，不包含它的子类
 这两个方法的区别在于，你仅使用系统的 UIButton 时，用 childrenMatchingType 就可以了，如果你还希望查询自己定义的子 Button，就要用 descendantsMatchingType
 UI 元素还有一些交互方法
 
 tap()：点击
 doubleTap()：双击
 pressForDuration(duration: NSTimeInterval)：长按一段时间，在你需要进行延时操作时，这个就派上用场了
 swipeUp()：这个响应不了 pan 手势，暂时没发现能用在什么地方，也可能是 beta 版的 bug，先不解释
 typeText(text: String)：用于 textField 和 textView 输入文本时使用，使用前要确保文本框获得输入焦点，可以使用 tap() 函数使其获得焦点
 
 
 //激活
    - (void)activate;
   终止
    - (void)terminate;
 */
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.




}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
