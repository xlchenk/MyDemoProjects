//
//  LLCycleScrollView.m
//  LLCycleScrollViewDemo
//
//  Created by chenxl on 2019/5/7.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "LLCycleScrollView.h"
#import "LLTimer.h"
#define K_WIDTH  self.bounds.size.width
@interface LLCycleScrollView()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,strong) LLTimer *clTimer;

@end
@implementation LLCycleScrollView{
    NSMutableArray *_imageSources;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageSources = [NSMutableArray array];
        [self addSubview:self.scrollView];
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((K_WIDTH-100)/2,self.bounds.size.height-20, 100, 20)];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        
        _currentIndex = 0;
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    self.scrollView.contentOffset = CGPointMake(K_WIDTH,0);
    self.scrollView.contentSize = CGSizeMake(K_WIDTH*(_imageArray.count+2), 0);
    [_imageSources addObjectsFromArray:_imageArray];
    
    [_imageSources insertObject:_imageArray.lastObject atIndex:0];
    [_imageSources insertObject:_imageArray.firstObject atIndex:_imageArray.count+1];
    
    
    [_imageSources enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(idx*K_WIDTH, 0, K_WIDTH, self.scrollView.bounds.size.height)];
        imageView.image = [UIImage imageNamed:obj];
        [self.scrollView addSubview:imageView];
    }];
//    [self setupTimer];
     [self setupPageControl:_imageArray.count];
}
- (void)setupPageControl:(NSInteger)pageCount{
    self.pageControl.numberOfPages = pageCount;
    self.pageControl.enabled = YES;
    [self addSubview:self.pageControl];
}
- (void)setupTimer{
    self.clTimer = [[LLTimer alloc]initWithTimerInterval:2 target:self selector:@selector(fire)];
}
- (void)fire{
    NSLog(@"dfdfs");
    [self autoScroll];
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }

    return _scrollView;
}
#pragma mark --注意这个方法will添加的时候走一次，要被销毁的时候也要走一次
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    //在其要被销毁的时候
    if (!newSuperview) {
        NSLog(@"willMoveToSuperview  销毁");
        [self.clTimer stop];
    };
}
-(void)autoScroll{
    
}

#pragma mamk - deletate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"偏移量---%f",scrollView.contentOffset.x);
    NSInteger offset = scrollView.contentOffset.x;
    
    if (offset==0) {
        scrollView.contentOffset = CGPointMake(_imageArray.count*K_WIDTH, 0);
        
    }
    if (offset==(_imageArray.count+1)*K_WIDTH) {
        scrollView.contentOffset = CGPointMake(K_WIDTH, 0);
    }
    NSInteger page = scrollView.contentOffset.x/K_WIDTH-1+0.5;
    
    
   
    NSLog(@"%f====页面--》%ld",scrollView.contentOffset.x/K_WIDTH+0.5,page);
    
    if (scrollView.contentOffset.x/K_WIDTH<0.5) {
        page = _imageArray.count-1;
    }
    
     self.pageControl.currentPage = page;
}
//开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}
//滑动停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"偏移量---%f",scrollView.contentOffset.x);
    NSInteger offset = scrollView.contentOffset.x;
    
    if (offset==0) {
        scrollView.contentOffset = CGPointMake(_imageArray.count*K_WIDTH, 0);
        
    }
    if (offset==(_imageArray.count+1)*K_WIDTH) {
        scrollView.contentOffset = CGPointMake(K_WIDTH, 0);
    }

//    NSInteger page = scrollView.contentOffset.x/K_WIDTH-1;
//    self.pageControl.currentPage = page;
//    NSLog(@"页面--》%ld",page);
}
//滑动减速
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}


@end
