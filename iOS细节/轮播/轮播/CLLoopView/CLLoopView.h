//
//  CLLoopView.h
//  轮播
//
//  Created by chenxl on 2019/5/6.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^handleBannerTapCallBlock)(NSInteger index);
NS_ASSUME_NONNULL_BEGIN

@interface CLLoopView : UIView

@property(nonatomic,copy) handleBannerTapCallBlock callBackBannerClick;
@property(nonatomic,strong) NSArray *imageArray;

@property(nonatomic,strong) UIColor *currentPageIndicatorTintColor;
@property(nonatomic,strong) UIColor *pageIndicatorTintColor;
@end

NS_ASSUME_NONNULL_END
