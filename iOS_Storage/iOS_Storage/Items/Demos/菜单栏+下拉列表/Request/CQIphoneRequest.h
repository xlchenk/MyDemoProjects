//
//  CQIphoneRequest.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CQIphoneRequest : NSObject

+ (void)loadMenuDataSuccess:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSString *errorMessage))failure;

+ (void)loadListDataWithID:(NSString *)ID success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSString *errorMessage))failure;

@end
