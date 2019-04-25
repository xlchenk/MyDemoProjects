//
//  CQThreadViewController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/23.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQThreadViewController.h"

@interface CQThreadViewController ()

@property (nonatomic, strong) NSMutableArray *numberArray;

@end

@implementation CQThreadViewController

- (NSMutableArray *)numberArray {
    if (!_numberArray) {
        _numberArray = [NSMutableArray array];
    }
    return _numberArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@", self.numberArray);
    });
}

- (void)mutiThread {
    
}



@end
