//
//  IphoneMenuView.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "IphoneMenuView.h"
#import "IphoneMenuButton.h"

const NSInteger ButtonBeginTag = 1000;

@implementation IphoneMenuView

- (void)setModel:(IphoneMenuModel *)model {
    _model = model;
    
    [self removeAllSubviews];
    
    NSMutableArray *buttonArray = [NSMutableArray array];
    
    for (int i = 0; i < _model.menu_list.count; i++) {
        IphoneMenuButton *button = [[IphoneMenuButton alloc] init];
        [self addSubview:button];
        button.tag = ButtonBeginTag + i;
        button.model = _model.menu_list[i];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
        [buttonArray addObject:button];
    }
    
    [buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
    }];
}

- (void)buttonClicked:(IphoneMenuButton *)sender {
    for (int i = 0; i < self.model.menu_list.count; i++) {
        IphoneMenuButton *button = [self viewWithTag:(ButtonBeginTag+i)];
        button.selected = (button.tag == sender.tag);
    }
    if ([self.delegate respondsToSelector:@selector(menuView:clickedButtonAtIndex:)]) {
        [self.delegate menuView:self clickedButtonAtIndex:(sender.tag-ButtonBeginTag)];
    }
}

/** 重置按钮状态 */
- (void)reset {
    for (int i = 0; i < self.model.menu_list.count; i++) {
        IphoneMenuButton *button = [self viewWithTag:(ButtonBeginTag+i)];
        button.selected = NO;
    }
}

@end
