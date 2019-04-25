//
//  CQSearchModel.h
//  iOS_Storage
//
//  Created by caiqiang on 2019/2/18.
//  Copyright © 2019年 蔡强. All rights reserved.
//

#import "CQBaseModel.h"

typedef NS_ENUM(NSUInteger, CQSearchType) {
    CQSearchTypeBinary
};

@interface CQSearchModel : CQBaseModel

@property (nonatomic, assign) CQSearchType type;
@property (nonatomic, copy) NSString *name;

@end
