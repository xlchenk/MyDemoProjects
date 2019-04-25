//
//  CQContentViewController.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQContentViewController : UIViewController

/**
 构造方法

 @param content 目录文件名称
 @return 目录controller
 */
- (instancetype)initWithContent:(NSString *)content;

@end
