//
//  GVStaticAnalysisViewController.m
//  002-Memory
//
//  Created by hzg on 2018/3/31.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "GVStaticAnalysisViewController.h"

@interface GVStaticAnalysisViewController ()

@end

@implementation GVStaticAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self problem0];
    [self problem1];
    [self problem2:nil];
    [self problem3];
}

#pragma mark - 问题
- (void)problem0
{
    CGPathRef shadowPath = CGPathCreateWithRect(self.inputView.bounds, NULL);
}

- (void)problem1
{
    FILE *fp;
    fp=fopen("info.plist", "r");
}

-(void) problem2:(void (^)(void))callback {
    callback();
}

-(NSArray*) problem3 {
    NSString *str = nil;
    return @[@"problem", str, @"problem3"];
}


@end
