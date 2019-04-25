//
//  CQIphoneViewController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQIphoneViewController.h"
#import "IphoneMenuView.h"
#import "IphoneListView.h"
#import "CQIphoneRequest.h"
#import "CQIphoneDetailViewController.h"

@interface CQIphoneViewController () <IphoneMenuViewDelegate>

@property (nonatomic, strong) IphoneMenuView *menuView;
@property (nonatomic, strong) IphoneListView *listView;

@end

@implementation CQIphoneViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // UI搭建
    [self setupUI];
    // 加载数据
    [self loadMenuDataSuccess:nil failure:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.listView) {
        [self.listView removeFromSuperview];
        self.listView = nil;
    }
}

- (void)dealloc {
    
}

#pragma mark - UI搭建

- (void)setupUI {
    self.menuView = [[IphoneMenuView alloc] init];
    [self.view addSubview:self.menuView];
    self.menuView.delegate = self;
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.height.mas_equalTo(60);
    }];
}

#pragma mark - Load Data

- (void)loadMenuDataSuccess:(void (^)(void))success failure:(void (^)(void))failure {
    [CQIphoneRequest loadMenuDataSuccess:^(NSDictionary *dataDict) {
        NSError *error = nil;
        IphoneMenuModel *model = [[IphoneMenuModel alloc] initWithDictionary:dataDict error:&error];
        self.menuView.model = model;
        !success ?: success();
    } failure:^(NSString *errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
        !failure ?: failure();
    }];
}

#pragma mark - 页面跳转

- (void)gotoDetailViewControllerWithModel:(IphoneListItemModel *)model {
    CQIphoneDetailViewController *detailVC = [[CQIphoneDetailViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - Delegate - menuView

// 菜单按钮点击
- (void)menuView:(IphoneMenuView *)menuView clickedButtonAtIndex:(NSInteger)index {
    IphoneMenuItemModel *model = menuView.model.menu_list[index];
    NSString *ID = [NSString stringWithFormat:@"%ld", (long)model.ID];
    // 获取列表数据
    [CQIphoneRequest loadListDataWithID:ID success:^(NSDictionary *dataDict) {
        if (self.listView) {
            [self.listView removeFromSuperview];
            self.listView = nil;
        }
        NSError *error = nil;
        IphoneListModel *listModel = [[IphoneListModel alloc] initWithDictionary:dataDict error:&error];
        CGFloat width = SCREEN_WIDTH / listModel.detail_list.count;
        __weak typeof(self) weakSelf = self;
        // 展示列表
        self.listView = [[IphoneListView alloc] initWithFrame:CGRectMake(index*width, NAVIGATION_BAR_HEIGHT+self.menuView.height, width, 60*listModel.detail_list.count) model:listModel cellSelectedBlock:^(NSInteger selectedIndex) {
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf gotoDetailViewControllerWithModel:listModel.detail_list[selectedIndex]];
            [strongSelf.menuView reset];
        }];
        [self.listView show];
    } failure:^(NSString *errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
    }];
}

@end
