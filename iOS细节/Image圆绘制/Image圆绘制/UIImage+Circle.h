//
//  UIImage+Circle.h
//  tttt
//
//  Created by chenxl on 2019/5/8.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Circle)
-(void)XL_cornerRadiusWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void(^)(UIImage *))completion;
@end

NS_ASSUME_NONNULL_END
