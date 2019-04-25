//
//  ViewController.m
//  001---单元测试
//
//  Created by Cooci on 2018/7/3.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (int)getPlus:(int)num1 num2:(int)num2{
    return num1 + num2 + 10;
}

- (void)loadData:(void (^)(id data))dataBlock{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:2];
        NSString *dataStr = @"meilo30";
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"刷新UI");
            dataBlock(dataStr);
        });
    });
}



- (void)openCamera{
    
    for (int i = 0; i<1000; i++) {
        NSLog(@"纪念 校长");
        // OA 耗时
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
