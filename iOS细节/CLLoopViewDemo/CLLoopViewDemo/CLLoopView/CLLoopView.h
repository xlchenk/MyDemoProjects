//
//  CLLoopView.h
//  CLLoopViewDemo
//
//  Created by chenxl on 2019/5/8.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^handleClickBannerCallBack)(NSInteger index);
NS_ASSUME_NONNULL_BEGIN

@interface CLLoopView : UIView
@property(nonatomic,copy) handleClickBannerCallBack bannerClickCallBack;
@property(nonatomic,strong) NSArray<NSString *> *imageArray;
@property(nonatomic,assign) NSTimeInterval interval;
@end

NS_ASSUME_NONNULL_END
