//
//  TimerWrapper.h
//  Performance004
//
//  Created by hzg on 2018/9/21.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerWrapper : NSObject

- (id) initWithTimerInterval:(NSTimeInterval)interval target:(id)target selector:(SEL) sel;

- (void) stop;

@end

NS_ASSUME_NONNULL_END
