//
//  Person.m
//  002---Crash分析
//
//  Created by Cooci on 2018/8/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)customCarsh{
    
    NSException *ex = [NSException exceptionWithName:NSArgumentDomain reason:[NSString stringWithFormat:@"I have a crash"] userInfo:@{@"crashNum":@10086}];
    
    // ex write 
    @throw ex;
}

@end
