//
//  CLCycleView.m
//  轮播
//
//  Created by chenxl on 2019/4/30.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "CLCycleView.h"
@interface CLCycleView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation CLCycleView

- (instancetype)initWithFrame:(CGRect)frame{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    
    
    
    
}


@end
