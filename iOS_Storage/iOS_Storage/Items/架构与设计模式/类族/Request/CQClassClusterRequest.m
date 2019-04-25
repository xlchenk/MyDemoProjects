//
//  CQClassClusterRequest.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/31.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQClassClusterRequest.h"

@implementation CQClassClusterRequest

+ (void)loadListDataSuccess:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure {
    // 加载本地json
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"class_cluster_data" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        success(dict[@"data"][@"list"]);
    });
}

@end
