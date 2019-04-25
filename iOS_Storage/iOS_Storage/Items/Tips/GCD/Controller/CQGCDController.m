//
//  CQGCDController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/27.
//  Copyright © 2018年 蔡强. All rights reserved.
//

/// GCD是纯c的API

#import "CQGCDController.h"

@interface CQGCDController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation CQGCDController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //dispatch_queue_t
    
    // 创建
//    dispatch_queue_create(<#const char * _Nullable label#>, <#dispatch_queue_attr_t  _Nullable attr#>)
//
//    // 使用
//    dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>);
}

@end
