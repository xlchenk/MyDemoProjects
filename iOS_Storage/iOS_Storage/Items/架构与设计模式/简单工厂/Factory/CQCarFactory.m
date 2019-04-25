//
//  CQCarFactory.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/9/11.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQCarFactory.h"
#import "CQCarBenz.h"
#import "CQCarBMW.h"

@implementation CQCarFactory

/**
 根据type生产对应类型的car
 
 @param type car的type
 @return 具体的car实例
 */
+ (CQCar *)produceCarWithType:(CQCarType)type {
    switch (type) {
        case CQCarTypeBenz: // 奔驰
        {
            CQCarBenz *benz = [[CQCarBenz alloc] init];
            return benz;
        }
            break;
            
        case CQCarTypeBMW: // 宝马
        {
            CQCarBMW *bmw = [[CQCarBMW alloc] init];
            return bmw;
        }
            break;
            
        default: // 一般的(比如说奥拓🙃)
        {
            CQCar *car = [[CQCar alloc] init];
            return car;
        }
            break;
    }
}

@end
