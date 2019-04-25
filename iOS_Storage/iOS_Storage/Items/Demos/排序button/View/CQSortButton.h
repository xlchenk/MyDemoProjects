//
//  CQSortButton.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/9/21.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQSortButton : UIButton

/** 按钮文本 */
@property (nonatomic, copy) NSString *title;
/** 是否是升序 */
@property (nonatomic, assign, readonly, getter=isAscending) BOOL ascending;

@end
