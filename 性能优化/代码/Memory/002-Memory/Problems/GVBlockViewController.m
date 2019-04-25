//
//  GVBlockViewController.m
//  002-Memory
//
//  Created by hzg on 2018/3/31.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "GVBlockViewController.h"
#import "GVDataSource.h"

static NSString *const kCellReuseIdentifier    = @"cellReuseIdentifier";

@interface GVBlockViewController ()

/// 问题数组
@property (strong, nonatomic) NSArray *problems;

/// DataSource
@property (strong, nonatomic) GVDataSource *dataSource;

/// 列表视图
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GVBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self.dataSource;
}

#pragma mark - 懒加载
- (NSArray *)problems
{
    if (!_problems) {
        _problems = @[@"block1", @"block2", @"block3", @"block4"];
    }
    return _problems;
}

- (GVDataSource *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[GVDataSource alloc] initWithItems:self.problems
                                           cellIdentifier:kCellReuseIdentifier
                                           tableViewStyle:UITableViewCellStyleDefault
                                       configureCellBlock:^(UITableViewCell *cell, NSString *item, NSIndexPath *indexPath) {
                                           cell.textLabel.text = item;
                                           [self blockRef];
                                       }];
    }
    return _dataSource;
}

- (void) blockRef {
    NSLog(@"blockRef");
}


@end
