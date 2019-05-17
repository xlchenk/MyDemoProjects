//
//  XLSegmentStyle.h
//  ScrollPageDemo
//
//  Created by chenxl on 2019/5/16.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface XLSegmentStyle : NSObject
@property(nonatomic,assign) CGFloat segmentHeight;
@property(nonatomic,assign) BOOL showLine;
@property(nonatomic,strong) UIFont *titleFont;
@property(nonatomic,strong) UIColor *selectedTitleColor;
@property(nonatomic,strong) UIColor *normalTitleColor;
@property(nonatomic,strong) UIColor *scrollLineColor;
@property(nonatomic,assign) CGFloat scrollLineHeight;
@property(nonatomic,assign) NSInteger marginW;
@end

NS_ASSUME_NONNULL_END
