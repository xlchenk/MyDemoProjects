//
//  ViewController.m
//  002-Memory
//
//  Created by hzg on 2018/3/31.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "ViewController.h"

/// 常量定义
static NSString *const kCellReuseIdentifier           = @"cellReuseIdentifier";
static NSString *const ksegueWildIdentifier           = @"segueWildIdentifier";
static NSString *const ksegueCycleRefIdentifier       = @"segueCycleRefIdentifier";
static NSString *const ksegueBlockIdentifier          = @"segueBlockIdentifier";
static NSString *const ksegueStaticAnalysisIdentifier = @"segueStaticAnalysisIdentifier";

/// 主控制器
@interface ViewController ()

/// 问题数组
@property (strong, nonatomic) NSArray *problems;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     静态分析
     动态检测 instrument
     dealloc
     
     */
}


#pragma mark - 懒加载
- (NSArray *)problemsList
{
    if (!_problems) {
        _problems = @[@"野指针", @"引用循环", @"Block问题", @"静态分析"];
    }
    return _problems;
}

#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.problemsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.problems[indexPath.row];
    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:ksegueWildIdentifier sender:self];
    }else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:ksegueCycleRefIdentifier sender:self];
    }else if(indexPath.row == 2) {
        [self performSegueWithIdentifier:ksegueBlockIdentifier sender:self];
    }else if (indexPath.row == 3) {
        [self performSegueWithIdentifier:ksegueStaticAnalysisIdentifier sender:self];
    }
}


@end
