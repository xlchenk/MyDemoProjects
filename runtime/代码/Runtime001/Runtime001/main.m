//
//  main.m
//  Runtime001
//
//  Created by hzg on 2018/9/10.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZPerson.h"
#import "TZDog.h"
#import <objc/runtime.h>


// 代码--> 编译链接--->执行

void run() {
    NSLog(@"%s", __func__);
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        TZPerson* p = [TZPerson new];
        
        TZDog* d = [TZDog new];
//        Method m1 = class_getInstanceMethod([p class], @selector(walk));
//        Method m2 = class_getInstanceMethod([p class], @selector(run));
//        //获取方法run的方法实现 IMP
//        IMP imp = method_getImplementation(m2);
//        //给m1设置方法实现编号
//
//        method_setImplementation(m1, imp);
//        [p walk]; //会执行run方法
//
        
        object_setClass(p, [d class]);
       // method_setImplementation(m1, (IMP)run);
        
        [p walk];
        
    }
    return 0;
}
