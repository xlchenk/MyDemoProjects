//
//  ViewController.m
//  Performance003
//
//  Created by hzg on 2018/9/21.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, copy) dispatch_block_t block;

@property (nonatomic, strong) NSString* str;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     
     ClassA* a = [ClassA new];
     ClassB* b = [ClassB new];
     a.b = b;
     b.a = a;
     
     */
    
// self -> block -> self
    //
    //__weak typeof (self) weakSelf = self;
    self.block = ^{
        
        __strong typeof (self) strongSelf = weakSelf;
      
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@", strongSelf.str);
        });
    };
    
    self.block();
}


@end
