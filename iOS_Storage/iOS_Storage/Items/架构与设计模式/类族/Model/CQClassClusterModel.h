//
//  CQClassClusterModel.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/30.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQBaseModel.h"

static NSString * const CQClassClusterCellAReuseID = @"CQClassClusterCellAReuseID";
static NSString * const CQClassClusterCellBReuseID = @"CQClassClusterCellBReuseID";
static NSString * const CQClassClusterCellCReuseID = @"CQClassClusterCellCReuseID";

typedef NS_ENUM(NSUInteger, CQClassClusterType) {
    CQClassClusterTypeA,
    CQClassClusterTypeB,
    CQClassClusterTypeC
};

@interface CQClassClusterModel : CQBaseModel

@property (nonatomic, assign) CQClassClusterType type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *cellReuseID;

@end
