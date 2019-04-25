//
//  Manager.h
//  001---OCMock依赖注入
//
//  Created by Cooci on 2018/8/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manager : NSObject

- (NSArray *)fetchDogs;

+ (NSArray *)fetchDogs2;


- (void)fetchDogsWithBlock:(void (^)(NSDictionary *result, NSError *error))block;

@end
