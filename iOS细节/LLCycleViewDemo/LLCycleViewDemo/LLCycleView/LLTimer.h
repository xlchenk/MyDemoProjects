//
//  LLTimer.h
//  LLCycleViewDemo
//
//  Created by chenxl on 2019/5/7.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLTimer : NSObject
- (instancetype)initWithTimerInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector;
-(void)stop;
@end

NS_ASSUME_NONNULL_END
