//
//  CQMultiInterfaceViewController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/20.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQMultiInterfaceViewController.h"

static NSString * const CQMultiInterfaceCellReuseID = @"CQMultiInterfaceCellReuseID";

@interface CQMultiInterfaceViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CQMultiInterfaceViewController

#pragma mark - getter

- (NSArray *)dataArray {
    return @[@"无序请求：使用GCD_GROUP请求多个接口",
             @"无序请求：使用信号量请求多个接口",
             @"有序请求：多个接口按顺序依次同步请求"];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CQMultiInterfaceCellReuseID];
}

#pragma mark - 使用GCD_GROUP请求多个接口

- (void)useGCDGroupLoadDataSuccess:(void (^)(void))success failure:(void (^)(void))failure {
    NSLog(@"使用GCD_GROUP请求多个接口");
    
    dispatch_group_t requestGroup = dispatch_group_create();
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 请求接口1
        dispatch_group_enter(requestGroup);
        [self loadData1Success:^{
            dispatch_group_leave(requestGroup);
        } failure:^{
            failure();
        }];
        
        // 请求接口2
        dispatch_group_enter(requestGroup);
        [self loadData2Success:^{
            dispatch_group_leave(requestGroup);
        } failure:^{
            failure();
        }];
        
        // 请求接口3
        dispatch_group_enter(requestGroup);
        [self loadData3Success:^{
            dispatch_group_leave(requestGroup);
        } failure:^{
            failure();
        }];
        
        // 所有接口请求完的回调
        dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
            success();
        });
    });
}

#pragma mark - 使用信号量请求多个接口

- (void)useSemaphoreLoadDataSuccess:(void (^)(void))success failure:(void (^)(void))failure {
    // 总共3个接口
    NSInteger totalCount = 3;
    __block NSInteger requestCount = 0;
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self loadData1Success:^{
//            if (++requestCount == totalCount) {
                dispatch_semaphore_signal(sem);
//            }
        } failure:nil];
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        [self loadData2Success:^{
//            if (++requestCount == totalCount) {
                dispatch_semaphore_signal(sem);
//            }
        } failure:nil];
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        [self loadData3Success:^{
//            if (++requestCount == totalCount) {
                dispatch_semaphore_signal(sem);
//            }
        } failure:nil];
        
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            success();
        });
    });
}

#pragma mark - 按顺序依次请求

- (void)loadDataByOrderSuccess:(void (^)(void))success failure:(void (^)(void))failure {
    // first,load data1
    NSBlockOperation * operation1 = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [self loadData1Success:^{
            dispatch_semaphore_signal(sema);
        } failure:^{
            !failure ?: failure();
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }];
    // then,load data2
    NSBlockOperation * operation2 = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [self loadData2Success:^{
            dispatch_semaphore_signal(sema);
        } failure:^{
            !failure ?: failure();
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }];
    // finally,load data3
    NSBlockOperation * operation3 = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [self loadData3Success:^{
            dispatch_semaphore_signal(sema);
        } failure:^{
            !failure ?: failure();
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        !success ?: success();
    }];
    [operation2 addDependency:operation1];
    [operation3 addDependency:operation2];
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[operation1, operation2, operation3] waitUntilFinished:NO];
}

#pragma mark - 三个接口

// 接口1（耗时2秒）
- (void)loadData1Success:(void (^)(void))success failure:(void (^)(void))failure {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showInfo:@"接口1请求完毕，耗时2秒"];
        success();
    });
}

// 接口2（耗时1秒）
- (void)loadData2Success:(void (^)(void))success failure:(void (^)(void))failure {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showInfo:@"接口2请求完毕，耗时1秒"];
        success();
    });
}

// 接口3（耗时0.5秒）
- (void)loadData3Success:(void (^)(void))success failure:(void (^)(void))failure {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showInfo:@"接口3请求完毕，耗时0.5秒"];
        success();
    });
}

- (void)showInfo:(NSString *)info {
    NSLog(@"%@", info);
    [SVProgressHUD showSuccessWithStatus:info];
}

#pragma mark - UITableView DataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CQMultiInterfaceCellReuseID forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            [self useGCDGroupLoadDataSuccess:^{
                [self showInfo:@"所有数据请求完毕"];
            } failure:nil];
        }
            break;
            
        case 1:
        {
            [self useSemaphoreLoadDataSuccess:^{
                [self showInfo:@"所有数据加载完成"];
            } failure:nil];
        }
            break;
            
        case 2:
        {
            [self loadDataByOrderSuccess:^{
                [self showInfo:@"所有数据加载完成"];
            } failure:nil];
        }
            break;
            
        default:
            break;
    }
}

@end
