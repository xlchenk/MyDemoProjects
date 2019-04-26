//
//  MyObject.m
//  ScriptCoreDemo01
//
//  Created by chenxl on 2019/4/26.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "MyObject.h"

@implementation MyObject
-(NSString *)updateUIWithParm:(NSString *)parm type:(NSString *)type{

    return [NSString stringWithFormat:@"parm--%@,type--%@",parm,type];
}

@end
