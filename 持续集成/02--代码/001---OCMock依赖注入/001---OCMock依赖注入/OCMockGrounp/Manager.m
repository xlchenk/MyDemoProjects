//
//  Manager.m
//  001---OCMock依赖注入
//
//  Created by Cooci on 2018/8/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "Manager.h"

@implementation Manager

- (NSArray *)fetchDogs{
    
    return @[];
}

+ (NSArray *)fetchDogs2{
    
    return @[];
}

- (void)fetchDogsWithBlock:(void (^)(NSDictionary *result, NSError *error))block{
    
    block(@{@"hh":@"hh"},nil);
}

@end
