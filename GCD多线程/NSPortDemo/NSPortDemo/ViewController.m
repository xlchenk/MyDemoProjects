//
//  ViewController.m
//  NSPortDemo
//
//  Created by chenxl on 2019/4/19.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
@interface ViewController ()<NSMachPortDelegate>{
    NSPort *myPort;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self test];
}
//线程间通信
/**
 NSMachPort
 
 NSPort有3个子类，NSSocketPort、NSMessagePort、NSMachPort，但在iOS下只有NSMachPort可用。
 */
-(void)test{
   Person * p1 = [[Person alloc]init];
//   创建主线程的Port  子线程通过这个端口发送消息给主线程
    myPort = [NSMachPort port];
    
    myPort.delegate = self;
    //把Port放到runloop中 接收port 消息
    [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
    
    //开启子线程 并把主线程的Port传入
    [NSThread detachNewThreadSelector:@selector(launchThreadWithPort:) toTarget:p1 withObject:myPort];
 
}
//portDelegate

- (void)handlePortMessage:(NSMessagePort *)message{
    NSLog(@"接收到子线程传递的消息%@",message);
    
    //接受到的消息ID
    NSInteger msgId = [[message valueForKeyPath:@"msgid"] integerValue];
    NSPort *locaPort = [message valueForKeyPath:@"localPort"];
    NSPort *remotePort = [message valueForKey:@"remotePort"];
//    [[NSRunLoop currentRunLoop] addPort:remotePort forMode:NSDefaultRunLoopMode];
    
      NSMutableArray * muArray = [NSMutableArray arrayWithObjects:@[@"2332342"], nil];
    if (msgId == kMsg1) {
        [remotePort sendBeforeDate:[NSDate date] msgid:kMsg2 components:muArray from:locaPort reserved:0];
    }else if (msgId == kMsg2){
        NSLog(@"dsfsdfsdfs");
    }
    
}


@end
