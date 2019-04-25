//
//  CQWaterfallCell.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/28.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQWaterfallCell.h"

@implementation CQWaterfallCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)setModel:(CQWaterfallModel *)model {
    _model = model;
    
}

@end
