//
//  KCOCMockTestCase.m
//  001---OCMock依赖注入Tests
//
//  Created by Cooci on 2018/8/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KCBaseTestCase.h"
#import "ViewController.h"
#import "Person.h"
#import <OCMock.h>
#import "OCMockViewController.h"

@interface KCOCMockTestCase : KCBaseTestCase

@end

@implementation KCOCMockTestCase

- (void)testPerson{

    Person *p = [[Person alloc] init];
    // cls ---> runtime
    Person *mock_p = OCMClassMock([Person class]);
    
    OCMStub([mock_p getPersonName]).andReturn(@"OCMock");

    XCTAssertEqualObjects([mock_p getPersonName], [p getPersonName],@"===");
}

- (void)testTableViewDelete{
    
    ViewController *vc = [[ViewController alloc] init];
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0]; // 0 1
    UITableView *tableView = [[UITableView alloc] init];
    // 虚拟的tablevIEW
    id tableView_ocmock = OCMClassMock([UITableView class]);
    [vc tableView:tableView_ocmock commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:path];
    [tableView_ocmock deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    
}


- (void)testMockDemo{
  
    // VC ---> 更新UI (VIEW) -->  数据(model) ---> manger
    
    OCMockViewController *vc = [[OCMockViewController alloc] init];
    // manager
    id manager = OCMClassMock([Manager class]);
    // 数据
    Dog *dog1 = [[Dog alloc] init];
    dog1.userName = @"123";
    Dog *dog2 = [[Dog alloc] init];
    dog2.userName = @"456";
    NSArray *array = @[dog1,dog2];
    OCMStub([manager fetchDogs]).andReturn(array);
    
    // 视图
    id cardView = OCMClassMock([IDCardView class]);
    vc.idCardView = cardView;
    OCMVerify([vc updateIDCardView]);
    
}





@end
