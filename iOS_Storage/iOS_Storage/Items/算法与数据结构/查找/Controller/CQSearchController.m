//
//  CQSearchController.m
//  iOS_Storage
//
//  Created by caiqiang on 2019/2/18.
//  Copyright © 2019年 蔡强. All rights reserved.
//

#import "CQSearchController.h"
#import "CQSearchModel.h"

@interface CQSearchController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <CQSearchModel *> *dataArray;

@end

@implementation CQSearchController

#pragma mark - Lazy Load

- (NSMutableArray<CQSearchModel *> *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
        NSArray *dictArray = @[@{@"name" : @"二分查找", @"type" : @(CQSearchTypeBinary)}];
        for (NSDictionary *dict in dictArray) {
            NSError *error = nil;
            CQSearchModel *model = [[CQSearchModel alloc] initWithDictionary:dict error:&error];
            [self.dataArray addObject:model];
        }
    }
    return _dataArray;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - 查找

- (void)searchWithType:(CQSearchType)type {
    switch (type) {
        case CQSearchTypeBinary: // 二分查找
        {
            NSArray *array = @[@1, @3, @5, @7, @9, @10, @20];
            NSInteger theNum = 1;
            NSInteger index = [self binarySearchIndexOfNum:theNum inArray:array];
            NSLog(@"二分查找：数字%ld在数组%@中的index是%ld", theNum, array, index);
        }
            break;
    }
}

#pragma mark 二分查找
/**
 二分查找

 @param num 要查找的数
 @param array 有序数组
 @return 这个数在这个数组中的index
 */
- (NSInteger)binarySearchIndexOfNum:(NSInteger)num inArray:(NSArray *)array {
    NSInteger minIndex = 0;
    NSInteger maxIndex = array.count;
    NSInteger midIndex = (minIndex + maxIndex) / 2;
    
    // 中间的这个数
    NSInteger midNum = [array[midIndex] integerValue];
    
    while (num != midNum) {
        if (num < midNum) {
            maxIndex = midIndex - 1;
        } else {
            minIndex = midIndex + 1;
        }
        midIndex = (minIndex + maxIndex) / 2;
        midNum = [array[midIndex] integerValue];
    }
    
    return midIndex;
}

#pragma mark - UITableView DataSource && Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellReuseID = @"cellReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseID];
    }
    cell.textLabel.text = self.dataArray[indexPath.row].name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self searchWithType:self.dataArray[indexPath.row].type];
}

@end
