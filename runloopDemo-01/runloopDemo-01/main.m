//
//  main.m
//  runloopDemo-01
//
//  Created by SJKJ on 2019/10/27.
//  Copyright © 2019 SJKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {//电信号通过硬件 把事件传递给的runloop
        /** 监听事件循环机制
         触摸 拖拽 时钟 网络
         
         参数：
         argc:
         参数长度
         argv:参数的值
         可执行文件的路径
        
         第三个参数是个nil: @"UIApplication"
         */
        NSLog(@"来了");
      
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
