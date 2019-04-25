//
//  Person.h
//  002---Crash分析
//
//  Created by Cooci on 2018/8/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, unsafe_unretained) NSString *name;

- (void)customCarsh;
@end
