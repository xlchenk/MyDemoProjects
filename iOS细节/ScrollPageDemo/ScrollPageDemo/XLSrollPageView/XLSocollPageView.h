//
//  XLSocollPageView.h
//  ScrollPageDemo
//
//  Created by chenxl on 2019/5/15.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLSegmentStyle.h"
#import "XLScrollViewChildVCDelegate.h"
NS_ASSUME_NONNULL_BEGIN
 
@interface XLSocollPageView : UIView

@property(nonatomic,assign) id<XLScrollViewChildVCDelegate>delegate;

@property(nonatomic,strong) UIColor *headerBackGroundColor;

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray<NSString *> *)titles
               segementStyle:(XLSegmentStyle *)segementStyle
                     childVCs:(NSArray<UIViewController *>*)childVCs
         parentViewController:(UIViewController *)parentViewController;

@end

NS_ASSUME_NONNULL_END
