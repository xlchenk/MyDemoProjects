//
//  CQAnimationViewController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/10/18.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQAnimationViewController.h"

@interface CQAnimationViewController () <CAAnimationDelegate>

/** 显式动画button */
@property (nonatomic, strong) UIButton *explicitAnimationButton;
/** 隐式动画button */
@property (nonatomic, strong) UIButton *implicitAnimationButton;

@end

@implementation CQAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.explicitAnimationButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 90, 90, 90)];
    [self.view addSubview:self.explicitAnimationButton];
    [self.explicitAnimationButton setTitle:@"显式动画" forState:UIControlStateNormal];
    self.explicitAnimationButton.backgroundColor = [UIColor redColor];
    [self.explicitAnimationButton addTarget:self action:@selector(explicitAnimationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.implicitAnimationButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 90, 90, 90)];
    [self.view addSubview:self.implicitAnimationButton];
    [self.implicitAnimationButton setTitle:@"隐式动画" forState:UIControlStateNormal];
    self.implicitAnimationButton.backgroundColor = [UIColor greenColor];
    [self.implicitAnimationButton addTarget:self action:@selector(implicitAnimationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

// 显式动画
// 不会改变最终layer的属性值
// CALayer动画，动画后frame未发生改变
- (void)explicitAnimationButtonClicked {
    NSLog(@"按钮点击");
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position"];
    ani.duration = 1.0;
    ani.fromValue = [NSValue valueWithCGPoint:self.explicitAnimationButton.layer.position];
    ani.toValue= [NSValue valueWithCGPoint:CGPointMake(220, 200)];
    ani.repeatCount = 1;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.delegate = self;
    [self.explicitAnimationButton.layer addAnimation:ani forKey:nil];
}

// 隐式动画
// 会改变layer属性
// UIView动画，动画后frame发生改变
// 动画过程中，view不相应用户交互
- (void)implicitAnimationButtonClicked {
    NSLog(@"按钮点击");
    NSLog(@"隐式动画开始，当前按钮位置%@", NSStringFromCGRect(self.implicitAnimationButton.frame));
    [UIView animateWithDuration:3 animations:^{
        self.implicitAnimationButton.frame = CGRectMake(190, 260, 90, 90);
    } completion:^(BOOL finished) {
        NSLog(@"隐式动画结束，当前按钮位置%@", NSStringFromCGRect(self.implicitAnimationButton.frame));
    }];
}

#pragma mark - CAAnimation Delegate

- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"显式动画开始，当前按钮位置%@", NSStringFromCGRect(self.explicitAnimationButton.frame));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"显式动画结束，当前按钮位置%@", NSStringFromCGRect(self.explicitAnimationButton.frame));
    // 你会发现，动画开始时和结束时的frame是相同的
    // 如果你打开“Debug View Hierarchy”，你会发现按钮的位置并没有改变
}

@end
