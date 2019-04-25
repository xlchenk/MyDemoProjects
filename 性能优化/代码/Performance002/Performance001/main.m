//
//  main.m
//  Performance001
//
//  Created by hzg on 2018/9/21.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void _objc_autoreleasePoolPrint(void);

int main(int argc, const char * argv[]) {

    @autoreleasepool {
        // 4096 - 56
        for (int i = 0; i < 3; i++) {
            NSObject* obj = [[[NSObject alloc] init] autorelease];
        }
        
        @autoreleasepool {
            for (int i = 0; i < 3; i++) {
                NSObject* obj = [[[NSObject alloc] init] autorelease];
            }
            _objc_autoreleasePoolPrint();
        }
        
    }
    
    return 0;
}
