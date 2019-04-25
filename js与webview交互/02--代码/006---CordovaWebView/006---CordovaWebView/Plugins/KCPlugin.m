//
//  KCPlugin.m
//  006---CordovaWebView
//
//  Created by Cooci on 2018/7/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KCPlugin.h"

@implementation KCPlugin
- (void)cordovaSubmit:(CDVInvokedUrlCommand *)command{
    // 接受参数
    NSArray *args = command.arguments;
    NSLog(@"args:%@",args);
    
    [self.commandDelegate runInBackground:^{
        NSLog(@"来了,,,,,,");
    }];
}

@end
