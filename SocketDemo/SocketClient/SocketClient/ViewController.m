//
//  ViewController.m
//  SocketClient
//
//  Created by SJKJ on 2019/10/30.
//  Copyright © 2019 SJKJ. All rights reserved.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <arpa/inet.h>
#import <netinet/in.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}






- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"111111");
//        [self performSelector:@selector(test) withObject:nil afterDelay:0];
//
//          NSLog(@"222222");
//         [[NSRunLoop currentRunLoop] run];
        
        [self performSelector:@selector(test) withObject:nil];
        
    });
}


-(void)test{
    NSLog(@"333333");
}
@end
