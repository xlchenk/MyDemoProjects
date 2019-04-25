//
//  CQClassClusterBaseCell.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/31.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQClassClusterModel.h"

@interface CQClassClusterBaseCell : UITableViewCell

+ (instancetype)cellWithType:(CQClassClusterType)type;

/** 子类重写setModel */
- (void)setModel:(CQClassClusterModel *)model;

@end
