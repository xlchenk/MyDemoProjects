//
//  NSObject+KVO.h
//  002-KVO的实现原理
//
//  Created by hzg on 2018/7/29.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (KVO) 

// 添加观察者
- (void)gv_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

//// 删除观察者
//- (void)gv_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end
