//
//  CQWarnTextField.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/29.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQWarnTextField.h"

@interface CQWarnTextField ()

@property (nonatomic, strong) CAShapeLayer *warnLayer;

@end

@implementation CQWarnTextField

- (void)createAlertLayer {
    // 设置layer相关属性
    self.warnLayer = [CAShapeLayer layer];
    // 大小和文本框一致
    self.warnLayer.frame = self.bounds;
    // 画线 非圆角
    self.warnLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.warnLayer.bounds cornerRadius:0].CGPath;
    // 线宽
    self.warnLayer.lineWidth = 6. / [[UIScreen mainScreen] scale];
    // 设置为实线
    self.warnLayer.lineDashPattern = nil;
    // 填充颜色透明色
    self.warnLayer.fillColor = [UIColor clearColor].CGColor;
    // 边框颜色为红色
    self.warnLayer.strokeColor = [UIColor redColor].CGColor;
    
    [self.layer addSublayer:self.warnLayer];
}

- (void)showWarn {
    [self createAlertLayer];
    
    // 透明度变化
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.repeatCount = 5;
    opacityAnimation.repeatDuration = 2;
    opacityAnimation.autoreverses = YES;
    [self.warnLayer addAnimation:opacityAnimation forKey:@"opacity"];
    
    // 2秒后移除动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2秒后异步执行这里的代码...
        // 移除动画
        [self.warnLayer removeFromSuperlayer];
    });
}

@end
