//
//  LLCycleView.m
//  LLCycleViewDemo
//
//  Created by chenxl on 2019/5/7.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "LLCycleView.h"
#import "LLTimer.h"
#import "LLCycleViewCell.h"
#import "LLCycleFlowLayout.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define K_WIDTH self.bounds.size.width
#define cellIdentifier @"cellIdentifier"
@interface LLCycleView ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,strong) LLTimer *clTimer;
@end
@implementation LLCycleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self->_imageArray.count == 1) {
                return ;
            }
            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:self->_imageArray.count inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            
        });
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((K_WIDTH-100)/2,self.bounds.size.height-20, 100, 20)];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        
        _currentIndex = 0;
        
        
        
    }
    return self;
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        LLCycleFlowLayout * layout = [[LLCycleFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[LLCycleViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    }
    return _collectionView;
}
- (void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    [self setupTimer];
    [self setupPageControl:_imageArray.count];
}
- (void)setupTimer{
    self.clTimer = [[LLTimer alloc]initWithTimerInterval:2 target:self selector:@selector(fire)];
    
}
- (void)fire{
    NSLog(@"dfdfs");
    
    
    [self autoScroll];
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
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
}
- (void)setupPageControl:(NSInteger)pageCount{
    self.pageControl.numberOfPages = pageCount;
    self.pageControl.enabled = YES;
    [self addSubview:self.pageControl];
}
#pragma mark -- collectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_imageArray.count == 1) {
        return _imageArray.count;
    }
    return _imageArray.count*200;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LLCycleViewCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.imageName = _imageArray[indexPath.row%_imageArray.count];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.callBackBannerClick) {
        self.callBackBannerClick(_currentIndex);
    }
}

-(void)autoScroll{
    CGFloat currentOffset = self.collectionView.contentOffset.x+K_WIDTH;
    NSInteger page =  currentOffset/K_WIDTH;
    NSInteger pageIndex = page%_imageArray.count;
    NSLog(@"页码--》%ld",pageIndex);
    
    if (page==0 ||page == ([self.collectionView numberOfItemsInSection:0]-1)) {
        if (page == 0) {
            page = _imageArray.count;
            
        }else{
            
            page = _imageArray.count-1;
            self.collectionView.contentOffset = CGPointMake(page*K_WIDTH, 0);
        }
        
    }
    [self.collectionView setContentOffset:CGPointMake(page*K_WIDTH, 0) animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"偏移量--》%f",scrollView.contentOffset.x);
    
    NSInteger page = scrollView.contentOffset.x/K_WIDTH+0.5;
    NSInteger pageIndex = page%_imageArray.count;
    _currentIndex = pageIndex;
    NSLog(@"ye ma %ld------%ld",pageIndex,page);
    self.pageControl.currentPage = pageIndex;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.clTimer stop];
}
#pragma mark -- 拖拽停止NSTimer
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/K_WIDTH;
    NSInteger pageIndex = page%_imageArray.count;
    self.pageControl.currentPage = pageIndex;
    if (page==0 ||page == ([self.collectionView numberOfItemsInSection:0]-1)) {
        if (page == 0) {
            NSLog(@"%ld",page);
            page = _imageArray.count;
        }else{
            NSLog(@"最后一页%ld",page);
            page = _imageArray.count-1;
        }
    }
    
    //重新设置offset
    scrollView.contentOffset = CGPointMake(page*SCREEN_WIDTH, 0);
    
}
//减速停止的时候执行
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self setupTimer];
}


@end
