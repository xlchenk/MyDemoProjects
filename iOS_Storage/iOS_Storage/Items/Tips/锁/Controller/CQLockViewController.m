//
//  CQLockViewController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/20.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQLockViewController.h"

static NSString * const CQLockViewCellReuseID = @"CQLockViewCellReuseID";

@interface CQLockViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSLock *lock;

@end

@implementation CQLockViewController

#pragma mark - getter

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"无锁多线程访问",
                       @"NSLock加锁多线程访问",
                       @"使用@synchronized加锁"];
    }
    return _dataArray;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.rowHeight = 40;
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CQLockViewCellReuseID];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - 无锁多线程访问
/** 无锁多线程访问 */
- (void)accessWithoutLock {
    NSLog(@"无锁多线程访问");
    self.time = 0;
    self.count = 0;
    // 两个线程调用changeWithoutLock方法
    [NSThread detachNewThreadSelector:@selector(changeWithoutLock) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(changeWithoutLock) toTarget:self withObject:nil];
}

- (void)changeWithoutLock {
    for (int i = 0; i < 100000; i++) {
        self.count ++;
    }
    self.time ++;
    if (self.time == 2) {
        NSLog(@"count===%ld", self.count);
    }
}

#pragma mark - NSLock加锁多线程访问

- (void)accessWithNSLock {
    NSLog(@"NSLock加锁多线程访问");
    if (self.lock) {
        self.lock = nil;
    }
    self.lock = [[NSLock alloc] init];
    self.time = 0;
    self.count = 0;
    // 两个线程调用changeWithNSLock方法
    [NSThread detachNewThreadSelector:@selector(changeWithNSLock) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(changeWithNSLock) toTarget:self withObject:nil];
}

- (void)changeWithNSLock {
    [self.lock lock];
    for (int i = 0; i < 100000; i++) {
        self.count ++;
    }
    self.time ++;
    if (self.time == 2) {
        NSLog(@"count===%ld", self.count);
    }
    [self.lock unlock];
}

#pragma mark - 使用@synchronized加锁

- (void)accessWithSynchronized {
    NSLog(@"使用@synchronized加锁");
    self.time = 0;
    self.count = 0;
    // 两个线程调用changeWithSynchronized方法
    [NSThread detachNewThreadSelector:@selector(changeWithSynchronized) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(changeWithSynchronized) toTarget:self withObject:nil];
}

- (void)changeWithSynchronized {
    @synchronized(self) {
        self.time++;
        for (int i = 0; i < 100000; i++) {
            self.count ++;
        }
        if (self.time == 2) {
            NSLog(@"count===%ld", self.count);
        }
    }
}

#pragma mark - UITableView DataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CQLockViewCellReuseID forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: // 多线程无锁访问
        {
            [self accessWithoutLock];
        }
            break;
            
        case 1: // NSLock加锁多线程访问
        {
            [self accessWithNSLock];
        }
            break;
            
        case 2: // 使用synchronized加锁
        {
            [self accessWithSynchronized];
        }
            break;
            
        default:
            break;
    }
}

@end
