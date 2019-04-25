//
//  NSObject+KVO.h
//  002-KVO的实现原理
//
//  Created by hzg on 2018/7/29.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^TZKVOBlock)(id observer, NSString* keyPath, id oldValue, id newValue);

@interface NSObject (KVO)


- (void) tz_addObserverBlock:(NSObject*) observer forKeyPath:(NSString*) keyPath handle:(TZKVOBlock) handleBlock;

// 添加观察者
//- (void)gv_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

//// 删除观察者
//- (void)gv_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end
