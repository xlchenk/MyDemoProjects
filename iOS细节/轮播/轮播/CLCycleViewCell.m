//
//  CLCycleViewCell.m
//  轮播
//
//  Created by chenxl on 2019/5/5.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "CLCycleViewCell.h"

@implementation CLCycleViewCell{
    UIImageView * _imageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
    }
    return self;
}



- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
  
    _imageView.image = [UIImage imageNamed:_imageName];
    
    
}
@end
