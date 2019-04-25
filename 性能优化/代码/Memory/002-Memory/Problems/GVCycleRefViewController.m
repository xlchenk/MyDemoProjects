//
//  GVCycleRefViewController.m
//  002-Memory
//
//  Created by hzg on 2018/3/31.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "GVCycleRefViewController.h"
#import "GVObject.h"

@interface GVCycleRefViewController ()

@end

@implementation GVCycleRefViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建两个对象a和b
    GVObject *a = [GVObject new];
    GVObject *b = [GVObject new];
    
    // 互相引用对方
    a.obj = b;
    b.obj = a;
}

@end
