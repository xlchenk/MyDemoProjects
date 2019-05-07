//
//  LLCycleFlowLayout.m
//  LLCycleViewDemo
//
//  Created by chenxl on 2019/5/7.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "LLCycleFlowLayout.h"

@implementation LLCycleFlowLayout
- (void)prepareLayout{
    [super prepareLayout];
    //    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width, 10);
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
}
@end
