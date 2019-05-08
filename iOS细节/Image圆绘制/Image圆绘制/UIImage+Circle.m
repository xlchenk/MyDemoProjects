//
//  UIImage+Circle.m
//  tttt
//
//  Created by chenxl on 2019/5/8.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "UIImage+Circle.h"

@implementation UIImage (Circle)
-(void)XL_cornerRadiusWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(nonnull void (^)(UIImage * _Nonnull))completion{
     NSTimeInterval start = CACurrentMediaTime();
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@",[NSThread currentThread]);
       
        //建立上下文 size 透明度
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        //贝塞尔路径裁切
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        //背景填充颜色
        [fillColor setFill];
        UIRectFill(rect);
        
        UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
        [path addClip];
        
        //重绘图像
        [self drawInRect:rect];
        
        //获取image
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        
        //关闭上下文
        UIGraphicsEndImageContext();
       
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion!=nil) {
                completion(image);
            }
        });
        
    });
  NSLog(@"%f",CACurrentMediaTime() -start);
}
@end
