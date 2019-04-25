//
//  KC_View.m
//  002---UITestDemo
//
//  Created by Cooci on 2018/5/29.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KC_View.h"

@implementation KC_View

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.customTF];
    }
    return self;
}
- (KC_TextField *)customTF{
    if (!_customTF) {
        _customTF = [[KC_TextField alloc] initWithFrame:self.bounds];
        _customTF.borderStyle = UITextBorderStyleRoundedRect;
        _customTF.layer.borderWidth = 1;
        _customTF.layer.borderColor = [UIColor orangeColor].CGColor;
        _customTF.placeholder = @"KCView子:请输入";
    }
    return _customTF;
}

@end
