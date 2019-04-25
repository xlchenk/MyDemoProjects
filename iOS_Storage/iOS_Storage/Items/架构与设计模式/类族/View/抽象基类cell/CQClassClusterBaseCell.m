//
//  CQClassClusterBaseCell.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/31.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQClassClusterBaseCell.h"
#import "CQClassClusterCellA.h"
#import "CQClassClusterCellB.h"
#import "CQClassClusterCellC.h"

@implementation CQClassClusterBaseCell

+ (instancetype)cellWithType:(CQClassClusterType)type {
    // 根据type创建对应的子类cell
    switch (type) {
        case CQClassClusterTypeA:
        {
            return [[CQClassClusterCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CQClassClusterCellAReuseID];
        }
            break;
            
        case CQClassClusterTypeB:
        {
            return [[CQClassClusterCellB alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CQClassClusterCellBReuseID];
        }
            break;
            
        case CQClassClusterTypeC:
        {
            return [[CQClassClusterCellC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CQClassClusterCellCReuseID];
        }
            break;
    }
}

// 不实现这个方法，有警告，很烦
- (void)setModel:(CQClassClusterModel *)model {
    // 子类重写
}

@end
