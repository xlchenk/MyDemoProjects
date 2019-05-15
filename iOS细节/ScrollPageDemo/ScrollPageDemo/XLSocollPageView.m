//
//  XLSocollPageView.m
//  ScrollPageDemo
//
//  Created by chenxl on 2019/5/15.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "XLSocollPageView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGTH [UIScreen mainScreen].bounds.size.height

#define RgbColor(r,g,b,a) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:a]
@interface XLSocollPageView ()<UIScrollViewDelegate>
@property (strong, nonatomic) NSArray *titlesArray;
@property (weak, nonatomic) UIViewController *parentViewController;
@property(nonatomic,strong) NSArray *childVCs;
@property(nonatomic,strong) UIScrollView *segementView;
@property(nonatomic,strong) UIScrollView *contentScrollView;
@property(nonatomic,strong) CALayer *bottomLine;


@end
@implementation XLSocollPageView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray<NSString *> *)titles
                     childVCs:(NSArray<UIViewController *>*)childVCs
         parentViewController:(UIViewController *)parentViewController{
    self = [super initWithFrame:frame];
    if (self) {
        _segmentHeight = 50;
        
        [self addSubview:self.segementView];
        [self addSubview:self.contentScrollView];
        self.parentViewController = parentViewController;
        self.titlesArray = titles;
        self.childVCs = childVCs;
        [self addChildVC];
        [self addTitles];
        [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    }
    return self;
}

-(void)addChildVC{
    if (self.childVCs.count>0) {
        for (UIViewController *vc in self.childVCs) {
            [self.parentViewController addChildViewController:vc];
        }
    }
}

- (void)addTitles{
    
    CGFloat btnW = 100;
    CGFloat btnY = 0;
    CGFloat btnH = self.segementView.frame.size.height;
    
    for (NSInteger i =0; i<self.childVCs.count; i++) {
        CGFloat btnX = btnW*i;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitle:[self.childVCs[i] title] forState:UIControlStateNormal];
        btn.tag = i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(headerItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.segementView addSubview:btn];
        if (i == 0) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
    }
    
    
    self.segementView.contentSize =CGSizeMake(btnW*self.childVCs.count, 0);
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.childVCs.count, 0);
    
    
    _bottomLine = [CALayer layer];
    _bottomLine.frame = CGRectMake(0, self.segementView.bounds.size.height-1, btnW, 1);
    _bottomLine.backgroundColor = [UIColor redColor].CGColor;
    [self.segementView.layer addSublayer:_bottomLine];
    
}
- (void)headerItemClick:(UIButton *)button{
    NSInteger index = button.tag;
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index*SCREEN_WIDTH;
    [self.contentScrollView setContentOffset:offset animated:YES];
}

- (void)setSegmentHeight:(NSInteger)segmentHeight{
    _segmentHeight = segmentHeight;
    CGRect frame = self.segementView.frame;
    frame.size.height = _segmentHeight;
    self.segementView.frame = frame;
    
    
    
    
}
- (void)setHeaderBackGroundColor:(UIColor *)headerBackGroundColor{
    _headerBackGroundColor = headerBackGroundColor;
    self.segementView.backgroundColor = _headerBackGroundColor;
}
#pragma mark -- 标题栏
- (UIScrollView *)segementView{
    if (!_segementView) {
        _segementView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y,self.bounds.size.width,_segmentHeight)];
        _segementView.showsVerticalScrollIndicator = NO;
        _segementView.showsHorizontalScrollIndicator = NO;
    }
    return _segementView;
}
#pragma mark -- 内容
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
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger index = offset/SCREEN_WIDTH;
    UIButton *btn = self.segementView.subviews[index];

    CGPoint titleOffset = self.segementView.contentOffset;


    titleOffset.x = btn.center.x-SCREEN_WIDTH/2;
    if (titleOffset.x<0) {
        titleOffset.x = 0;
    }
    if (titleOffset.x>self.segementView.contentSize.width-SCREEN_WIDTH) {
        titleOffset.x = self.segementView.contentSize.width-SCREEN_WIDTH;
    }
    [self.segementView setContentOffset:titleOffset animated:YES];
    //可能会出现其他颜色还停留在渐变中 所有重置一下其他按钮颜色
    for (UIButton *button in self.segementView.subviews) {
        if (button != btn) [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

    UIViewController *vc = self.childVCs[index];
    if ([vc isViewLoaded]) {
        return;
    }
    vc.view.frame = CGRectMake(offset, 0, SCREEN_WIDTH, self.contentScrollView.frame.size.height);
    [self.contentScrollView addSubview:vc.view];
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
