//
//  CQClassClusterRequest.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/31.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CQClassClusterRequest : NSObject

+ (void)loadListDataSuccess:(void (^)(NSArray *list))success failure:(void (^)(NSString *errorMessage))failure;

@end
