//
//  CQIphoneRequest.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQIphoneRequest.h"

@implementation CQIphoneRequest

+ (void)loadMenuDataSuccess:(void (^)(NSDictionary *))success failure:(void (^)(NSString *))failure {
    // 加载本地数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"iphone_menu_data" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    !success ?: success(responseDict[@"data"]);
}

+ (void)loadListDataWithID:(NSString *)ID success:(void (^)(NSDictionary *))success failure:(void (^)(NSString *))failure {
    // 加载本地数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"iphone_list_data" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    !success ?: success(responseDict[@"data"]);
}

@end
