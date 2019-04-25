//
//  CQTransitionController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQTransitionController.h"

@interface CQTransitionController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation CQTransitionController

#pragma mark - getter

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
        for (int i = 1; i <= 3; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"number_%d", i]];
            [_imageArray addObject:image];
        }
    }
    return _imageArray;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"fade", @"moveIn", @"push", @"reveal", @"cube"];
    }
    return _dataArray;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, NAVIGATION_BAR_HEIGHT+20, 100, 100)];
    [self.view addSubview:self.imageView];
    self.imageView.image = self.imageArray.firstObject;
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(20);
    }];
}

#pragma mark - UITableView DataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const cellReuseID = @"cellReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseID];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSInteger i = 0;
    i++;
    if (i == 3) {
        i = 0;
    }
    self.imageView.image = self.imageArray[i];
    CATransition *anim = [CATransition animation];
    anim.type = self.dataArray[indexPath.row];
    [self.imageView.layer addAnimation:anim forKey:nil];
}

@end
