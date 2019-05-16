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
#define marginW 20;
@interface XLSocollPageView ()<UIScrollViewDelegate>
@property (strong, nonatomic) NSArray *titlesArray;
@property (weak, nonatomic) UIViewController *parentViewController;
@property(nonatomic,strong) NSArray *childVCs;
@property(nonatomic,strong) UIScrollView *segementView;
@property(nonatomic,strong) UIScrollView *contentScrollView;
@property(nonatomic,strong) CALayer *bottomLine;
@property(nonatomic,strong) NSMutableArray *titleWidthArr;

@end
@implementation XLSocollPageView{
    XLSegmentStyle *_segementStyle;
}
- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray<NSString *> *)titles
               segementStyle:(XLSegmentStyle *)segementStyle
                     childVCs:(NSArray<UIViewController *>*)childVCs
         parentViewController:(UIViewController *)parentViewController{
    self = [super initWithFrame:frame];
    if (self) {
        _segementStyle = segementStyle;
        
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
    CGFloat titlesWidth = 0;
    
    for (NSInteger i =0; i<self.childVCs.count; i++) {
       
    
//        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//        paragraphStyle.alignment = NSTextAlignmentCenter;
//
//        NSAttributedString *string = [[NSAttributedString alloc]initWithString:[self.childVCs[i] title] attributes:@{NSFontAttributeName:_segementStyle.titleFont, NSParagraphStyleAttributeName:paragraphStyle}];
//
//        CGSize size =  [string boundingRectWithSize:CGSizeMake(MAXFLOAT, _segementStyle.segmentHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
//        NSLog(@" size =  %@", NSStringFromCGSize(size));
//
//        btnW = ceil(size.width)+marginW;
        
        btnW = [self getStringWidthByString:[self.childVCs[i] title] height:_segementStyle.segmentHeight index:i];
        
        titlesWidth+=btnW;
        
        [_titleWidthArr addObject:@(titlesWidth)];
        CGFloat btnX = titlesWidth-btnW;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitle:[self.childVCs[i] title] forState:UIControlStateNormal];
        btn.tag = i;
        btn.titleLabel.font = _segementStyle.titleFont;
        [btn setTitleColor:_segementStyle.normalTitleColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(headerItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.segementView addSubview:btn];
        if (i == 0) {
            [btn setTitleColor:_segementStyle.selectedTitleColor forState:UIControlStateNormal];
        }
        
    }
    
    
    self.segementView.contentSize =CGSizeMake(titlesWidth, 0);
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.childVCs.count, 0);
    
    if (!_segementStyle.showLine)return;
    _bottomLine = [CALayer layer];
    CGFloat firstBtnWidth = [self getStringWidthByString:[self.childVCs[0] title] height:btnH index:0];
    
    _bottomLine.frame = CGRectMake(0, self.segementView.bounds.size.height-_segementStyle.scrollLineHeight, firstBtnWidth, _segementStyle.scrollLineHeight);
    _bottomLine.backgroundColor = _segementStyle.scrollLineColor.CGColor;
    [self.segementView.layer addSublayer:_bottomLine];
    
}
- (void)headerItemClick:(UIButton *)button{
    NSInteger index = button.tag;
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index*SCREEN_WIDTH;
    [self.contentScrollView setContentOffset:offset animated:YES];
}

- (CGFloat)getStringWidthByString:(NSString *)string height:(CGFloat)height index:(NSInteger)index{
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *muStr = [[NSAttributedString alloc]initWithString:[self.childVCs[index] title] attributes:@{NSFontAttributeName:_segementStyle.titleFont, NSParagraphStyleAttributeName:paragraphStyle}];
    CGSize size =  [muStr boundingRectWithSize:CGSizeMake(MAXFLOAT, _segementStyle.segmentHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    NSLog(@" size =  %@", NSStringFromCGSize(size));
   CGFloat width = ceil(size.width)+marginW;
    return width;
}
- (void)setHeaderBackGroundColor:(UIColor *)headerBackGroundColor{
    _headerBackGroundColor = headerBackGroundColor;
    self.segementView.backgroundColor = _headerBackGroundColor;
}
#pragma mark -- 标题栏
- (UIScrollView *)segementView{
    if (!_segementView) {
        _segementView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y,self.bounds.size.width,_segementStyle.segmentHeight)];
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
