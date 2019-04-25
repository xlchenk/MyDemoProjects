//
//  TZPerson.h
//  KVO001
//
//  Created by hzg on 2018/9/17.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TZPerson : NSObject

// 步数
@property (nonatomic, assign) int steps;

// 依赖关系的成员
@property (nonatomic, strong) NSString* fullName;
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;

@end
