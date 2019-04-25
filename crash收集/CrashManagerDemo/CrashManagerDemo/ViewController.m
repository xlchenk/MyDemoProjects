//
//  ViewController.m
//  CrashManagerDemo
//
//  Created by chenxl on 2019/4/11.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) NSArray * array;
@property(nonatomic,assign) int a;
@property(nonatomic,strong) NSDictionary * dict;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _array = @[@"xiao",@"lng",@"ww"];
    _dict = @{@"name":@"xiaom",@"age":@"123"};
    
}

-(void)test1{
//    NSLog(@"%@",[_array objectAtIndex:3]);
    NSLog(@"---%@",_dict[@"NULL"]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
[self test1];
}
@end
