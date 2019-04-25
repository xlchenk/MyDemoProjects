//
//  KC_JSObject.m
//  003---JavaScriptCoreDemo
//
//  Created by Cooci on 2018/7/26.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KC_JSObject.h"

@implementation KC_JSObject

- (void)letShowImage:(NSString *)str{
    
    NSLog(@"打开相册,上传图片 --- %@",str);
}

- (int)getSum:(int)num1 num2:(int)num2{
    return num1+num2;
}

@end
