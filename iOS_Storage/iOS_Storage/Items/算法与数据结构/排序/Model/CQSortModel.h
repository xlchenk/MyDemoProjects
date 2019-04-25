//
//  CQSortModel.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/8/22.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQBaseModel.h"

typedef NS_ENUM(NSUInteger, CQSortType) {
    CQSortTypeBubble,
    CQSortTypeSelection,
    CQSortTypeInsertion,
    CQSortTypeQuick
};

@interface CQSortModel : CQBaseModel

@property (nonatomic, assign) CQSortType type;
@property (nonatomic, copy) NSString *name;

@end
