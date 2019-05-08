//
//  CLLoopView.m
//  CLLoopViewDemo
//
//  Created by chenxl on 2019/5/8.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "CLLoopView.h"
#import "LLTimer.h"
#define K_WIDTH  self.bounds.size.width
#define K_HEIGHT  self.bounds.size.height

@interface CLLoopView()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIImageView *centerImageView;
@property(nonatomic,strong) UIImageView *leftImageView;
@property(nonatomic,strong) UIImageView *rightImageView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,strong) LLTimer *timer;
@end
@implementation CLLoopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((K_WIDTH-100)/2,self.bounds.size.height-20, 100, 20)];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _currentIndex = 0;
        _interval = 2;
    }
    return self;
}
- (void)setInterval:(NSTimeInterval)interval{
    _interval = interval;
}
- (void)setImageArray:(NSArray<NSString *> *)imageArray{
    _imageArray = imageArray;
    _currentIndex = 0;
    
    [self setImageByIndex];
    [self setupPageControl:_imageArray.count];
     [self setupTimer];
}
- (void)setupPageControl:(NSInteger)pageCount{
    self.pageControl.numberOfPages = pageCount;
    self.pageControl.enabled = YES;
    [self addSubview:self.pageControl];
}
-(void)setImageByIndex{
    NSString * currentImageName = _imageArray[_currentIndex];
    self.centerImageView.image = [UIImage imageNamed:currentImageName];
    //左边的imageview位置放最后最后一个图 让他一开始往右边滑动的时候 显示最后一个图
    NSInteger leftIndex = (_currentIndex-1+_imageArray.count)%_imageArray.count;
    self.leftImageView.image = [UIImage imageNamed:_imageArray[leftIndex]];
    NSInteger rightIndex = (_currentIndex+1)%_imageArray.count;
    self.rightImageView.image = [UIImage imageNamed:_imageArray[rightIndex]];
    //因为显示区域只有centerImageView
    self.centerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bannerClick:)];
    [self.centerImageView addGestureRecognizer:tap];
    
    self.pageControl.currentPage=_currentIndex;
}
-(void)bannerClick:(UIGestureRecognizer *)tap{
    if (self.bannerClickCallBack) {
        self.bannerClickCallBack(_currentIndex);
    }
}

-(void)resetImageLocation{
    if (self.scrollView.contentOffset.x>K_WIDTH) {
        _currentIndex = (_currentIndex+1)%_imageArray.count;
    }
    if (self.scrollView.contentOffset.x<K_WIDTH) {
        _currentIndex = (_currentIndex-1+_imageArray.count)%_imageArray.count;
    }
    
    [self setImageByIndex];
}

- (void)setupTimer{
    if (_imageArray.count==1) return;
    self.timer = [[LLTimer alloc]initWithTimerInterval:_interval target:self selector:@selector(fire)];
}

- (void)fire{
    NSLog(@"fire");
    [self autoScroll];
}

-(void)autoScroll{
    [self.scrollView setContentOffset:CGPointMake(2 * K_WIDTH, 0) animated:YES];
}
#pragma mark -- 拖拽停止NSTimer
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //滑动的时候停止定时器
    [self.timer stop];
    
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self resetImageLocation];
    self.scrollView.contentOffset = CGPointMake(K_WIDTH,0);
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //滑动结束后刷新图片位置
    [self resetImageLocation];
    // 滑动结束后 复位到center位置
    self.scrollView.contentOffset = CGPointMake(K_WIDTH, 0);
    [self.scrollView setContentOffset:CGPointMake(K_WIDTH, 0) animated:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //滑动结束重新开启定时器
     [self setupTimer];
}
#pragma mark -- 添加的时候走一次，要被销毁的时候也要走一次
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    //在其要被销毁的时候
    if (!newSuperview) {
        NSLog(@"willMoveToSuperview  销毁");
        [self.timer stop];
    };
}


- (UIImageView *)centerImageView {
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(K_WIDTH, 0, K_WIDTH, K_HEIGHT)];
        [_centerImageView.layer setMasksToBounds:YES];
        _centerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _centerImageView.backgroundColor = [UIColor whiteColor];
    }
    return _centerImageView;
}

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, K_WIDTH, K_HEIGHT)];
        [_leftImageView.layer setMasksToBounds:YES];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        _leftImageView.backgroundColor = [UIColor redColor];
    }
    return _leftImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * K_WIDTH, 0, K_WIDTH, K_HEIGHT)];
        [_rightImageView.layer setMasksToBounds:YES];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _rightImageView.backgroundColor = [UIColor whiteColor];
    }
    return _rightImageView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor cyanColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.contentOffset = CGPointMake(K_WIDTH, 0);
        _scrollView.contentSize = CGSizeMake(K_WIDTH*3, 0);
        [_scrollView addSubview:self.centerImageView];
        [_scrollView addSubview:self.leftImageView];
        [_scrollView addSubview:self.rightImageView];
    }
    return _scrollView;
}
@end
