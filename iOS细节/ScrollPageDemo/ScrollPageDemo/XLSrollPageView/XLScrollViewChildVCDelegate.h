//
//  XLScrollViewChildVCDelegate.h
//  ScrollPageDemo
//
//  Created by SJKJ on 2019/5/17.
//  Copyright © 2019 chenxl. All rights reserved.


#import <UIKit/UIKit.h>

@protocol XLScrollViewChildVCDelegate <NSObject>
- (void)xl_viewDidAppearForIndex:(NSInteger)index;
@end

