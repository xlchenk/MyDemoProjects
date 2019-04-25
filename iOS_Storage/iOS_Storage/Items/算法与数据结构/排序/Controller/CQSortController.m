//
//  CQSortController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/8/22.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQSortController.h"
#import "CQSortModel.h"

@interface CQSortController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <CQSortModel *> *dataArray;

@end

@implementation CQSortController

#pragma mark - Lazy Load

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        NSArray *dictArray = @[@{@"name" : @"冒泡排序", @"type" : @(CQSortTypeBubble)},
                               @{@"name" : @"选择排序", @"type" : @(CQSortTypeSelection)},
                               @{@"name" : @"插入排序", @"type" : @(CQSortTypeInsertion)},
                               @{@"name" : @"快速排序", @"type" : @(CQSortTypeQuick)}];
        for (NSDictionary *dict in dictArray) {
            NSError *error = nil;
            CQSortModel *model = [[CQSortModel alloc] initWithDictionary:dict error:&error];
            [_dataArray addObject:model];
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

#pragma mark - 排序

- (void)sortWithType:(CQSortType)type {
    switch (type) {
        case CQSortTypeBubble: // 冒泡排序
        {
            [self bubbleSort];
        }
            break;
            
        case CQSortTypeSelection: // 选择排序
        {
            [self selectionSort];
        }
            break;
            
        case CQSortTypeInsertion: // 插入排序
        {
            NSArray *array = @[@1, @8, @3, @6, @6, @6, @7, @5, @9, @2];
            NSArray *sortedArray = [self insertionSortArray:array];
            NSLog(@"插入排序前：%@ \n 插入排序后：%@", array, sortedArray);
        }
            break;
            
        case CQSortTypeQuick: // 快速排序
        {
            NSArray *array = @[@9, @3, @6, @7, @5, @1, @2];
            NSArray *sortedArray = [self quickSortArray:array];
            NSLog(@"快速排序前：%@ \n 快速排序后：%@", array, sortedArray);
        }
            
        default:
            break;
    }
}

#pragma mark 冒泡排序
- (void)bubbleSort {
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@1, @3, @2, @99, @33]];
    NSLog(@"冒泡排序前：%@", array);
    NSInteger count = 0;
    for (NSUInteger i = array.count; i > 0; i--) {
        // 比较相邻两个数，将大的那个数放在后面
        // 每轮循环可以将最大的数放到末尾
        for (NSUInteger j = 1; j < i; j++) {
            count ++;
            if (array[j-1] > array[j]) {
                // 交换数组元素
                [array exchangeObjectAtIndex:j withObjectAtIndex:(j-1)];
            }
        }
    }
    NSLog(@"冒泡排序后：%@", array);
    NSLog(@"运算次数：%ld", count);
}

#pragma mark 选择排序

// 从第一个元素开始，分别跟后面的元素比较
- (void)selectionSort {
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@1, @3, @2, @99, @33]];
    NSLog(@"选择排序前：%@", array);
    NSInteger count = 0;
    NSInteger temp;
    for (int i = 0; i < array.count-1; i++) {
        // 每轮循环可以把最小的数放到最前面
        for (int j = i+1; j < array.count; j++) {
            count ++;
            if ([array[i] integerValue] < [array[j] integerValue]) {
                temp = [array[i] integerValue];
                array[i] = array[j];
                array[j] = [NSNumber numberWithInteger:temp];
                
//                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    NSLog(@"选择排序后：%@", array);
    NSLog(@"运算次数：%ld", count);
}

#pragma mark 插入排序
/**
 插入排序

 @param array 待排序的数组
 @return 排好序的数组
 */
- (NSArray *)insertionSortArray:(NSArray *)array {
    // 这是排序好的数组
    NSMutableArray *sortedArray = [NSMutableArray array];
    // 先将待排序数组中的第一个元素加入排序好的数组
    [sortedArray addObject:array.firstObject];
    
    // 依次取出剩下的待排序元素跟排序好的数组中的元素比较
    for (int i = 1; i < array.count; i++) {
        // 如果比最后一个元素大，说明这个待排序元素是最大的，直接加到数组末尾
        if ([array[i] integerValue] > [sortedArray.lastObject integerValue]) {
            // 插入
            [sortedArray addObject:array[i]];
            continue; // 结束此次循环
        }
        // 如果插入的这个元素不是最大的，跟排序好的数组中的元素一一比较
        for (int j = 0; j < sortedArray.count; j++) {
            if ([array[i] integerValue] <= [sortedArray[j] integerValue]) {
                // 插入
                [sortedArray insertObject:array[i] atIndex:j];
                break; // 注意及时break这个for循环
            }
        }
    }
    
    return sortedArray;
}

#pragma mark 快速排序
/**
 快速排序

 @param array 待排序的数组
 @return 排序完成的数组
 */
- (NSArray *)quickSortArray:(NSArray *)array {
    if (array.count < 2) { // 基线条件
        return array;
    } else {
        // 将数组第一个元素设定为基线
        NSInteger base = [array.firstObject integerValue];
        
        // 分成大小两个数组
        NSMutableArray *smallArray = [NSMutableArray array];
        NSMutableArray *bigArray = [NSMutableArray array];
        
        for (int i = 1; i < array.count; i++) {
            NSInteger num = [array[i] integerValue];
            if (num < base) {
                // 左边部分是比基线小的元素组成的数组
                [smallArray addObject:[NSNumber numberWithInteger:num]];
            } else {
                // 右边部分是比基线大的元素组成的数组
                [bigArray addObject:[NSNumber numberWithInteger:num]];
            }
        }
        
        // 排列好的数组，包含三部分
        NSMutableArray *sortedArray = [NSMutableArray array];
        
        // 对左边的数组进行快排（递归）
        for (NSNumber *num in [self quickSortArray:smallArray]) {
            [sortedArray addObject:num];
        }
        
        // 中间部分是基线
        [sortedArray addObject:@(base)];
        
        // 对右边的数组进行快排（递归）
        for (NSNumber *num in [self quickSortArray:bigArray]) {
            [sortedArray addObject:num];
        }
        
        return sortedArray;
    }
}

#pragma mark - UITableView DataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellReuseID = @"cellReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseID];
    }
    cell.textLabel.text = self.dataArray[indexPath.row].name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self sortWithType:self.dataArray[indexPath.row].type];
}

@end
