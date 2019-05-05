//
//  CLCycleView.m
//  轮播
//
//  Created by chenxl on 2019/4/30.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "CLCycleView.h"
#import "CLCycleViewCell.h"
#import "CLCycleFlowLayout.h"
#import "AppDelegate.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define cellIdentifier @"cellIdentifier"
@interface CLCycleView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UIView *pageControl;
@end
@implementation CLCycleView

- (instancetype)initWithFrame:(CGRect)frame{
    CLCycleFlowLayout * layout = [[CLCycleFlowLayout alloc]init];
   
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
//        self.delegate = self;
//        self.dataSource = self;
//
//
//        [self registerClass:[CLCycleViewCell class] forCellWithReuseIdentifier:cellIdentifier];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:self->_imageArray.count inSection:0];
//            [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//        });
//

        
        
        self.backgroundColor = [UIColor redColor];
       
    }
    
    return self;
}

- (void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    
    
   
    _pageControl = [[UIView alloc]initWithFrame:CGRectMake(80, 60, 100, 60)];
    _pageControl.backgroundColor = [UIColor greenColor];
//    UIWindow *window = A;
    window.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [window addSubview:_pageControl];
}


#pragma mark -- delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLCycleViewCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    cell.imageName = _imageArray[indexPath.row%_imageArray.count];
    return cell;
}


#pragma mark -- 拖拽停止NSTimer
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/SCREEN_WIDTH;
   NSLog(@"页码--》%ld",page%_imageArray.count);
    if (page==0 ||page == ([self numberOfItemsInSection:0]-1)) {
        
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
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    NSInteger page = scrollView.contentOffset.x/SCREEN_WIDTH;
//    NSLog(@"dfasfsd页码--》%ld",page%_imageArray.count);
//}

@end
