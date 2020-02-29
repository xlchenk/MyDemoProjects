//
//  TZSecondViewController.m
//  KVO001
//
//  Created by hzg on 2018/9/17.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "TZSecondViewController.h"
#import "TZPerson.h"

@interface TZSecondViewController ()
@property (nonatomic, strong) TZPerson* p;
@end

@implementation TZSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _p = [TZPerson new];
    
    /// 添加观察者
    [_p addObserver:self forKeyPath:@"steps" options:NSKeyValueObservingOptionPrior | NSKeyValueObservingOptionNew context:nil];
}


// 实现监听方法
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
}
 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_p willChangeValueForKey:@"steps"];
    _p.steps++;
    [_p didChangeValueForKey:@"steps"];
   // _p.firstName = @"三";
}

- (void) dealloc {
    [_p removeObserver:self forKeyPath:@"steps"];
}



@end
