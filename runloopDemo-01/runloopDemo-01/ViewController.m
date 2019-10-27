//
//  ViewController.m
//  runloopDemo-01
//
//  Created by SJKJ on 2019/10/27.
//  Copyright © 2019 SJKJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)NSThread * thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    
    
    
}



-(void)test3{
    /** runloop解决界面渲染 消耗性能 主线程的耗时操作
     耗时操作的c拆分 分段 通过每次的runloop循环里，只加载一张图
     
     
     
     
     */
}

-(void)test2{
    
    /**和线程的关系
     线程任务 执行完毕之后 会回收，s所以不会执行回调方法
     线程对象是强引用，不会消失，但是 线程是回收，因为线程的回收和对象是没有关系的,线程是CPU调用的
     
     
     nonatomic :线程不安全的 意味着 多条线程可以抢夺资源！ 但 效率高
     natomic：有锁 线程安全的 影响效率
     所以UI的操作只允许主线程的操作
     
     
     */
    /**如何让线程常驻
     
     
     
     
     */
    _thread = [[NSThread alloc]initWithBlock:^{
        NSTimer * timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(myTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        NSLog(@"laidff");
        //如何保住线程 让线程不停的做事情
//        while (true) {
//            //到事件队列中取出然后执行
//        }

        //开启runloop循环
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"1111111");
        //结论：子线中runloop默认是不开启的，需要手动开启
    }];
    
    [_thread start];
    //
}



- (void)test1{
    /**
     [NSRunLoop currentRunLoop];
     NSRunLoop 只是对象本身 runloop 是不可以新建的，但是可以通过  [NSRunLoop currentRunLoop]; 拿到当前线程的runloop
     
     */
    NSTimer * timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(myTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    /**
     处理事件顺序：
     timer事件 放到了默认模式下 ，硬件产生电信号 通知runloop去处理 执行回调myTimer的代码
     执行完成之后 ，runloop会顺延 等待下一秒钟去处理执行方法 就这样不断循环
     1/ 问题：同时当滑动屏幕的时候，会触发UI模式，runloop会优先处理UI模式下的滑动事件
     2/  那将其放在UI模式下，滑动的时候，同时也会执行timer事件,但是UI 模式只能背UI事件所唤醒，停止拖拽，都会停止
     
     
     
     RunLoopMode 有五种模式
     NSDefaultRunLoopMode;
     NSRunLoopCommonModes
     UITrackingRunLoopMode
     
     
     
     */
}


-(void)myTimer{
    
    NSLog(@"come heare");
    
    [NSThread sleepForTimeInterval:1];
    NSLog(@"%@",[NSThread currentThread]);
}



@end
