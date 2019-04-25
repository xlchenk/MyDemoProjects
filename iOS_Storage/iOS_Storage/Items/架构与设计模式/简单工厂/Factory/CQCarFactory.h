//
//  CQCarFactory.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/9/11.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CQCar.h"

typedef NS_ENUM(NSUInteger, CQCarType) {
    /** 奔驰 */
    CQCarTypeBenz,
    /** 宝马 */
    CQCarTypeBMW
};

@interface CQCarFactory : NSObject


/**
 根据type生产对应类型的car

 @param type car的type
 @return 具体的car实例
 */
+ (CQCar *)produceCarWithType:(CQCarType)type;

@end
