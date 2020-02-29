//
//  main.m
//  Runtime001
//
//  Created by hzg on 2018/9/10.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZPerson.h"

extern void instrumentObjcMessageSends(BOOL);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //runtime 消息打印
        instrumentObjcMessageSends(YES);
        [TZPerson walk];
        instrumentObjcMessageSends(NO);
    }
    return 0;
}
