//
//  CQClassClusterController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/30.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQClassClusterController.h"
#import "CQClassClusterBaseCell.h"
#import "CQClassClusterRequest.h"

@interface CQClassClusterController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CQClassClusterController

#pragma mark - getter

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    
    __weak typeof(self) weakSelf = self;
    [self loadDataSuccess:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.tableView reloadData];
    } failure:nil];
}

- (void)dealloc {
    NSLog(@"释放");
}

#pragma mark - Load Data

- (void)loadDataSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMessage))failure {
    [SVProgressHUD show];
    [CQClassClusterRequest loadListDataSuccess:^(NSArray *list) {
        [self.dataArray removeAllObjects];
        // 组装数据源
        for (NSDictionary *dict in list) {
            NSError *error = nil;
            CQClassClusterModel *model = [[CQClassClusterModel alloc] initWithDictionary:dict error:&error];
            [self.dataArray addObject:model];
            switch (model.type) {
                case CQClassClusterTypeA:
                {
                    model.cellReuseID = CQClassClusterCellAReuseID;
                }
                    break;
                case CQClassClusterTypeB:
                {
                    model.cellReuseID = CQClassClusterCellBReuseID;
                }
                    break;
                case CQClassClusterTypeC:
                {
                    model.cellReuseID = CQClassClusterCellCReuseID;
                }
                    break;
            }
        }
        [SVProgressHUD dismiss];
        !success ?: success();
    } failure:^(NSString *errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
        !failure ?: failure(errorMessage);
    }];
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CQClassClusterModel *model = self.dataArray[indexPath.row];
    CQClassClusterBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellReuseID];
    if (!cell) {
        // 类族模式
        cell = [CQClassClusterBaseCell cellWithType:model.type];
    }
    [cell setModel:model];
    return cell;
}

@end
