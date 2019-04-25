//
//  ViewController.m
//  线程01
//
//  Created by chenxl on 2019/4/18.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) NSString *parm;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /**
     并发队列
     串行队列
     
     同步线程  并发队列:
     同步线程  串行队列:
     
     异步线程  并发队列:
     异步线程  串行队列:
     
     */
    
    //队列挂起 任务是否执行？
    
    
}


-(void)demo1{
    self.parm = @"";
    __weak typeof(self)weakSelf = self;
     dispatch_group_t group = dispatch_group_create();
     dispatch_group_enter(group);
         dispatch_async(dispatch_get_global_queue(0, 0), ^{
             [self requestParmsToken:^(id value) {
                 weakSelf.parm = value;
//                 NSLog(@"%@",[NSThread currentThread]);
                 dispatch_group_leave(group);
             }];
         });
    dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [self requestListDataWithParms:@"11" handle:^(id listData) {
                NSLog(@"%@--%@",listData,weakSelf.parm);
                NSLog(@"%@",[NSThread currentThread]);
                dispatch_group_leave(group);
            } failureBlock:^(id error) {
                NSLog(@"%@",error);
                 dispatch_group_leave(group);
            }];
        });
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [self requestListDataWithParms:@"ddddddd" handle:^(id listData) {
                NSLog(@"%@-----%@",listData,weakSelf.parm);
                NSLog(@"%@",[NSThread currentThread]);
               dispatch_group_leave(group);
            } failureBlock:^(id error) {
                NSLog(@"%@",error);
               dispatch_group_leave(group);
            }];
        });
        
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"请求完毕");
    });
   //用group组 子线程执行任务，等所有的任务执行完毕后  再做些跟新UI的事情 z需要注意的是 任务执行的时候是没有顺序的
}
-(void)demo2{
    //dispatch_semaphore_t 信号量操作 可以顺序执行
    self.parm = @"";
    __weak typeof(self)weakSelf = self;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self requestParmsToken:^(id value) {
            weakSelf.parm = value;
            // NSLog(@"%@",[NSThread currentThread]);
            dispatch_semaphore_signal(semaphore);
        }];
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self requestListDataWithParms:@"11" handle:^(id listData) {
            NSLog(@"%@--%@",listData,weakSelf.parm);
            NSLog(@"%@",[NSThread currentThread]);
            dispatch_semaphore_signal(semaphore);
           
        } failureBlock:^(id error) {
            NSLog(@"%@",error);
            dispatch_semaphore_signal(semaphore);
           
        }];
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self requestListDataWithParms:@"ddddddd" handle:^(id listData) {
            NSLog(@"%@-----%@",listData,weakSelf.parm);
            NSLog(@"%@",[NSThread currentThread]);
            dispatch_semaphore_signal(semaphore);
            
        } failureBlock:^(id error) {
            NSLog(@"%@",error);
            dispatch_semaphore_signal(semaphore);
            
        }];
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_main_queue(), ^{
         NSLog(@"执行完毕");
        dispatch_semaphore_signal(semaphore);
    });
    
    
}
//
-(void)demo3{
  
    
    
    
    
}
-(void)requestParmsToken:(void (^)(id value))successBlock{
    [NSThread sleepForTimeInterval:2];
    successBlock(@"124al443p5p1u54j542p24u515w4q344");
}

-(void)requestListDataWithParms:(NSString *)parms handle:(void (^)(id listData))handleBlock failureBlock:(void(^)(id error))failureBlock{
//    [NSThread sleepForTimeInterval:0.5];
    handleBlock([NSString stringWithFormat:@"列表数据--%@",parms]);
    if (parms == nil ||parms.length == 0) {
        failureBlock(@"请求错误");
    }
    
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self demo2];
}
-(void)test{
 //串行队列   DISPATCH_QUEUE_SERIAL
 //并发队列   DISPATCH_QUEUE_CONCURRENT
    
    dispatch_queue_t queue = dispatch_queue_create("name1", DISPATCH_QUEUE_SERIAL);
    NSLog(@"ddd");
    dispatch_async(queue, ^{
        NSLog(@"222");
        //会形成死锁
        dispatch_sync(queue, ^{
            NSLog(@"33");
        });
        NSLog(@"444");
    });
    NSLog(@"555");
}
//同步线程 主队列不可以放在同步线程里
-(void)test2{
    //会形成死锁
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"ddd");
    });
}

-(void)test3{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
}
@end
