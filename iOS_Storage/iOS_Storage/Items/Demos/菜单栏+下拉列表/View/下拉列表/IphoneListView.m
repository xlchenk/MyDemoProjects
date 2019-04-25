//
//  IphoneListView.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "IphoneListView.h"
#import "IphoneListCell.h"

static NSString * const IphoneListCellReuseID = @"IphoneListCellReuseID";

@interface IphoneListView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) IphoneListModel *model;
/** cell点击的回调 */
@property (nonatomic, copy) CellSelectedBlock cellSelectedBlock;

@end

@implementation IphoneListView

#pragma mark - 构造方法

- (instancetype)initWithFrame:(CGRect)frame model:(IphoneListModel *)model cellSelectedBlock:(CellSelectedBlock)cellSelectedBlock {
    if (self = [super initWithFrame:frame]) {
        self.model = model;
        self.cellSelectedBlock = cellSelectedBlock;
        [self setupUI];
    }
    return self;
}

#pragma mark - UI搭建

- (void)setupUI {
    self.tableView = [[UITableView alloc] init];
    [self addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    [self.tableView registerClass:[IphoneListCell class] forCellReuseIdentifier:IphoneListCellReuseID];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - 展示

- (void)show {
    [[[[UIApplication sharedApplication] delegate] window]  addSubview:self];
}

#pragma mark - UITableView DataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.detail_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IphoneListCell *cell = [tableView dequeueReusableCellWithIdentifier:IphoneListCellReuseID];
    cell.model = self.model.detail_list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.cellSelectedBlock ?: self.cellSelectedBlock(indexPath.row);
    [self removeFromSuperview];
}

@end
