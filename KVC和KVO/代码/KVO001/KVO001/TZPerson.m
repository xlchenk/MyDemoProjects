//
//  TZPerson.m
//  KVO001
//
//  Created by hzg on 2018/9/17.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "TZPerson.h"

@implementation TZPerson

- (NSString*)fullName {
    return [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
}


+ (NSSet*) keyPathsForValuesAffectingFullName
{
    return [NSSet setWithObjects:@"lastName", @"firstName", nil];
}

+ (BOOL) automaticallyNotifiesObserversOfSteps {
    return NO;
}

@end
