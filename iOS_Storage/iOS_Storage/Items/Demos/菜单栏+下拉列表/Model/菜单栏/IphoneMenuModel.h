//
//  IphoneMenuModel.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQBaseModel.h"
#import "IphoneMenuItemModel.h"

@protocol IphoneMenuItemModel;

@interface IphoneMenuModel : CQBaseModel

@property (nonatomic, strong) NSArray <IphoneMenuItemModel> *menu_list;

@end
