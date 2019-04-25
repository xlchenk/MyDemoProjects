//
//  IphoneListCell.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "IphoneListCell.h"

@interface IphoneListCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation IphoneListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor orangeColor];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setModel:(IphoneListItemModel *)model {
    _model = model;
    
    self.nameLabel.text = _model.name;
}

@end
