//
//  IphoneListModel.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQBaseModel.h"
#import "IphoneListItemModel.h"

@protocol IphoneListItemModel;

@interface IphoneListModel : CQBaseModel

@property (nonatomic, strong) NSArray <IphoneListItemModel> *detail_list;

@end
