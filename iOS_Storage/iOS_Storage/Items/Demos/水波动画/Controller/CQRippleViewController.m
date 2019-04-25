//
//  CQRippleViewController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/10/8.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQRippleViewController.h"

@interface CQRippleViewController ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CQRippleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-100, 200, 200)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 78, 78)];
    blueView.backgroundColor = [UIColor blueColor];
    view.maskView = blueView;
    
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = CGRectMake(0, 200, 375, 150);
    [self.view.layer addSublayer:_shapeLayer];
    
    _shapeLayer.fillColor = [UIColor greenColor].CGColor; // 没有这句代码，裁剪区域是黑色
    //_shapeLayer.borderColor = [UIColor blackColor].CGColor;
    // 小了白了兔，白了又了白
    //_shapeLayer.borderWidth = 2;
    _shapeLayer.strokeColor = [UIColor blueColor].CGColor;


    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(100, 20)];
    [path addLineToPoint:CGPointMake(375, 0)];
    [path closePath];
    //[path addLineToPoint:CGPointZero];

    _shapeLayer.path = path.CGPath;
    
    
    
//    CALayer *layer = [CALayer layer];
//    [self.view.layer addSublayer:layer];
//    layer.frame = CGRectMake(90, 250, 400, 30);
//    layer.backgroundColor = [UIColor redColor].CGColor;
    
}

@end
