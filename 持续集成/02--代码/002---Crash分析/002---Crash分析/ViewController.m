//
//  ViewController.m
//  002---Crash分析
//
//  Created by Cooci on 2018/8/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"
#import <signal.h>
#import "Person.h"

typedef struct Test
{
    int a;
    int b;
}Test;

@interface ViewController ()

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSDictionary *dataDict;
@property (nonatomic, copy) NSString *dataStr;
@property (nonatomic, strong) Person *person;

@end

@implementation ViewController


void kcUncaughtException (NSException *exc){
    
    NSString *excName = [exc name];
    NSString *excReas = [exc reason];
    NSArray *excArray = [exc callStackSymbols];
    
    NSString *crashLog = [NSString stringWithFormat:@"错误名字:%@\n 错误原因:%@\n 错误信息:%@\n",excName,excReas,excArray];
    NSLog(@"%@",crashLog);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"天王盖地虎",@"宝塔镇河妖"];
    self.dataDict  = @{@"name":@"Cooci",@"age":@18};
    self.dataStr   = @"carsh分析";
    self.person    = [[Person alloc] init];
    
    
}

- (IBAction)didCllickGoUAction:(id)sender {
    
//    Test *pTest = {1,2};
//    free(pTest);
//    pTest->a = 5;
    
    [self.person customCarsh];
    
}

- (IBAction)didClickTestArrayCrashAction:(id)sender {
    
    NSLog(@"************************************");
    
    NSLog(@"%@",self.dataArray[6]);
}

- (IBAction)didClickTestDictCrashAction:(id)sender {
    
    NSLog(@"************************************");
    
    [self.dataDict[@"age"] isEqualToString:@"18"];
}

- (IBAction)didClickTestStringCrashAction:(id)sender {
    
    NSLog(@"************************************");
    
    NSLog(@"%@",[self.dataStr substringToIndex:66]);
}


@end
