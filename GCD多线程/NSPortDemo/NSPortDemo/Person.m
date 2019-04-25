//
//  Person.m
//  NSPortDemo
//
//  Created by chenxl on 2019/4/19.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "Person.h"


@interface Person()<NSMachPortDelegate> {
    NSPort *remotePort;
    NSPort *myPort;
}

@end

@implementation Person
-(void)launchThreadWithPort:(NSPort *)port{
    @autoreleasepool {
        NSLog(@"personxiNc%@",[NSThread currentThread]);
        //保存主线程的port
        remotePort = port;
        //子线程名字
        [[NSThread currentThread] setName:@"PersonClassThread"];
        
        [[NSRunLoop currentRunLoop] run];
        //创建自己port
        myPort = [NSMachPort port];
        myPort.delegate = self;
        //自己的Port 放到runloop
        [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
        [self sendPortMessage];
        

    }
}
//发送消息到主线程
-(void)sendPortMessage{
    NSMutableArray * muArray = [NSMutableArray arrayWithObjects:@[@"xiaom",@"wang",@"lisi"], nil];
    //发送消息到主线程
    [remotePort sendBeforeDate:[NSDate date] msgid:kMsg1 components:muArray from:myPort reserved:0];
}

#pragma portdelegate
- (void)handlePortMessage:(NSMessagePort *)message{
    NSLog(@"44接收到主线程的消息%@",message);
     NSLog(@"person当前线程%@",[NSThread currentThread]);}

@end
