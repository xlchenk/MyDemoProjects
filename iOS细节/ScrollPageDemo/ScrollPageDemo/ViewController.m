//
//  ViewController.m
//  ScrollPageDemo
//
//  Created by chenxl on 2019/5/13.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGTH [UIScreen mainScreen].bounds.size.height

#define RgbColor(r,g,b,a) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:a]
@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *segementView;
@property(nonatomic,strong) UIScrollView *contentScrollView;
@property(nonatomic,strong) CALayer *bottomLine;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.segementView];
    [self.view addSubview:self.contentScrollView];
    [self addTitles];
    // 默认显示第0个子控制器
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

- (void)addTitles{
    NSArray *titles = @[@"餐宴网",@"饿了么",@"美团",@"百度外卖",@"农夫山泉",@"富士康",@"美丽天津"];
    CGFloat btnW = 100;
    CGFloat btnY = 0;
    CGFloat btnH = self.segementView.frame.size.height;
    
    for (NSInteger i =0; i<titles.count; i++) {
        CGFloat btnX = btnW*i;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(headerItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.segementView addSubview:btn];
        if (i == 0) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
    }
    
    
    self.segementView.contentSize =CGSizeMake(btnW*titles.count, 0);
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*titles.count, 0);
    
    
    _bottomLine = [CALayer layer];
    _bottomLine.frame = CGRectMake(0, btnH-1, btnW, 1);
    _bottomLine.backgroundColor = [UIColor blueColor].CGColor;
    [self.segementView.layer addSublayer:_bottomLine];
//
    
}
- (void)headerItemClick:(UIButton *)button{
    NSInteger index = button.tag;
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index*SCREEN_WIDTH;
    [self.contentScrollView setContentOffset:offset animated:YES];
}
- (UIScrollView *)segementView{
    if (!_segementView) {
        _segementView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH ,50+1)];
        _segementView.showsVerticalScrollIndicator = NO;
        _segementView.showsHorizontalScrollIndicator = NO;
    }
    return _segementView;
}

- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segementView.frame), SCREEN_WIDTH, SCREEN_HEIGTH-CGRectGetMaxY(self.segementView.frame))];
        _contentScrollView.delegate = self;
        _contentScrollView.pagingEnabled = YES;
//        _contentScrollView.backgroundColor =[UIColor cyanColor];
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _contentScrollView;
}
//动画d滚动结束的时候执行
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndScrollingAnimation--%f",scrollView.contentOffset.x);
    CGPoint offset = scrollView.contentOffset;
    NSInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
    UIButton *btn = self.segementView.subviews[index];
    offset.x = btn.center.x-SCREEN_WIDTH/2;
    if (offset.x<0) {
        offset.x = 0;
    }
    if (offset.x>self.segementView.contentSize.width-SCREEN_WIDTH) {
        offset.x = self.segementView.contentSize.width-SCREEN_WIDTH;
    }
    [self.segementView setContentOffset:offset animated:YES];
    //可能会出现其他颜色还停留在渐变中 所有重置一下其他按钮颜色
    for (UIButton *button in self.segementView.subviews) {
        if (button != btn) [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    CGFloat scale = offset/SCREEN_WIDTH;
    
    NSInteger leftIndex = scale;
    NSInteger rightIndex = leftIndex+1;
    
    UIButton *leftBtn = self.segementView.subviews[leftIndex];
    UIButton *rightBtn = (rightIndex==self.segementView.subviews.count)?nil:self.segementView.subviews[rightIndex];
    
    CGFloat rightScale = scale - leftIndex;
    CGFloat leftScale = 1- rightScale;
//    0.4 0.6 0.7
//    leftLb.textColor = RgbColor(0.4+0.6*leftScale, 0.6-0.6*leftScale, 0.7-0.7*leftScale, 1);
//    rigitLb.textColor = RgbColor(0.4+0.6*rightScale, 0.6-0.6*rightScale, 0.7-0.7*rightScale, 1);
    [leftBtn setTitleColor:RgbColor(leftScale, 0, 0, 1) forState:UIControlStateNormal];
    [rightBtn setTitleColor:RgbColor(rightScale, 0, 0, 1) forState:UIControlStateNormal];
    NSLog(@"%f---%f",leftScale,rightScale);
    
    CGRect frame = self.bottomLine.frame;
    CGFloat lbW = leftBtn.frame.size.width;
    frame.origin.x = lbW*scale;
    self.bottomLine.frame = frame;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}


@end
