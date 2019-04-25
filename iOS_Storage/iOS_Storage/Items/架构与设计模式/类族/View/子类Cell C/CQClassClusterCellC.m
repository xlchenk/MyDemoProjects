//
//  CQClassClusterCellC.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/31.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQClassClusterCellC.h"

@interface CQClassClusterCellC ()

@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation CQClassClusterCellC

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.centerImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.centerImageView];
    [self.centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.top.mas_equalTo(2);
        make.bottom.mas_offset(-2);
        make.width.mas_equalTo(self.centerImageView.mas_height);
    }];
    
    self.leftLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.leftLabel];
    self.leftLabel.textAlignment = NSTextAlignmentRight;
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_offset(0);
        make.right.mas_equalTo(self.centerImageView.mas_left).mas_offset(-10);
    }];
    
    self.rightLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_offset(0);
        make.left.mas_equalTo(self.centerImageView.mas_right).mas_offset(10);
    }];
}

- (void)setModel:(CQClassClusterModel *)model {
    self.centerImageView.image = [UIImage imageNamed:model.image];
    self.leftLabel.text = self.rightLabel.text = model.title;
}

@end
