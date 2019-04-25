//
//  CQIrregularViewController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQIrregularViewController.h"
#import "IrregularLabel.h"
#import "ArrowLabel.h"
#import "RoundArrowLabel.h"

@interface CQIrregularViewController ()

@property (nonatomic, strong) IrregularLabel *label;

@end

@implementation CQIrregularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.label = [[IrregularLabel alloc] initWithFrame:CGRectMake(90, 100, 200, 40)];
    [self.view addSubview:self.label];
    self.label.text = @"点击屏幕发生变化";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor redColor];
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont boldSystemFontOfSize:16];
    
    // 箭头label
    ArrowLabel *arrowLabel = [[ArrowLabel alloc] initWithFrame:CGRectMake(150, 220, 80, 80)];
    [self.view addSubview:arrowLabel];
    arrowLabel.textAlignment = NSTextAlignmentCenter;
    arrowLabel.font = [UIFont systemFontOfSize:14];
    arrowLabel.text = @"箭头label";
    arrowLabel.backgroundColor = [UIColor orangeColor];
    
    // 圆尖角label
    RoundArrowLabel *roundArrowLabel = [[RoundArrowLabel alloc] initWithFrame:CGRectMake(80, 320, 100, 60)];
    [self.view addSubview:roundArrowLabel];
    roundArrowLabel.textAlignment = NSTextAlignmentCenter;
    roundArrowLabel.font = [UIFont systemFontOfSize:15];
    roundArrowLabel.text = @"圆尖角label";
    roundArrowLabel.backgroundColor = [UIColor greenColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.label.frame = CGRectMake(30, 120, 222, 70);
}

@end
