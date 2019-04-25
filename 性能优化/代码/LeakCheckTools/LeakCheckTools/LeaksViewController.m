//
//  LeaksViewController.m
//  LeakCheckTools
//
//  Created by hzg on 2018/5/17.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "LeaksViewController.h"

typedef void (^Block)(void);

@interface LeaksViewController ()

@property (nonatomic, copy) Block b;
@property (nonatomic, strong) NSString* name;

@end

@implementation LeaksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.b = ^{
        self.name = @"Tom";
    };
    
}

- (void) dealloc {
    NSLog(@"dealloc");
}

@end
