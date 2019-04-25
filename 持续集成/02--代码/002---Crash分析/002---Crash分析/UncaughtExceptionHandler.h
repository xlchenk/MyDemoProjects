//
//  UncaughtExceptionHandler.h
//  002---Crash分析
//
//  Created by Cooci on 2018/8/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UncaughtExceptionHandler : NSObject
{
    BOOL dismissed;
}

+ (void)InstallUncaughtExceptionHandler;

@end
