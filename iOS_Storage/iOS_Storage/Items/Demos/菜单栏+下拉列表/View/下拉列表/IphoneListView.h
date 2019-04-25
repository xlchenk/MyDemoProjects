//
//  IphoneListView.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IphoneListModel.h"

typedef void(^CellSelectedBlock)(NSInteger selectedIndex);

@interface IphoneListView : UIView

- (instancetype)initWithFrame:(CGRect)frame model:(IphoneListModel *)model cellSelectedBlock:(CellSelectedBlock)cellSelectedBlock;

- (void)show;

@end
