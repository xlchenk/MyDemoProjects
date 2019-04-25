//
//  CQClassClusterCellA.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/31.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQClassClusterCellA.h"

@interface CQClassClusterCellA ()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation CQClassClusterCellA

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.leftImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(2);
        make.bottom.mas_offset(-2);
        make.width.mas_equalTo(self.leftImageView.mas_height);
    }];
    
    self.rightLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_offset(0);
        make.left.mas_equalTo(self.leftImageView.mas_right).mas_offset(10);
    }];
}

- (void)setModel:(CQClassClusterModel *)model {
    self.leftImageView.image = [UIImage imageNamed:model.image];
    self.rightLabel.text = model.title;
}

@end
