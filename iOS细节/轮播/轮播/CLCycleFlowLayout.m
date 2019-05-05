//
//  CLCycleFlowLayout.m
//  轮播
//
//  Created by chenxl on 2019/5/5.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "CLCycleFlowLayout.h"

@implementation CLCycleFlowLayout
- (void)prepareLayout{
    [super prepareLayout];
    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width, 10);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
}
@end
