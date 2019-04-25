//
//  main.m
//  Performance001
//
//  Created by hzg on 2018/9/21.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <Foundation/Foundation.h>

struct Test {
    Test() {
        printf("Test() \n");
    }
    
    ~Test() {
        printf("~Test() \n");
    }
};

int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        // autorelease  延迟调用release
//    }
    //objc_autoreleasePoolPush();
    
    //autorelease
    
    // objc_autoreleasePoolPop(atautoreleasepoolobj)
    {
        Test t;
    }
    
    return 0;
}

/*
 
 {
 
 __AtAutoreleasePool __autoreleasepool;
 
 }
 
 struct __AtAutoreleasePool {
  __AtAutoreleasePool() {atautoreleasepoolobj = objc_autoreleasePoolPush();}
 ~__AtAutoreleasePool() {objc_autoreleasePoolPop(atautoreleasepoolobj);}
  void * atautoreleasepoolobj;
 };
 
 */
