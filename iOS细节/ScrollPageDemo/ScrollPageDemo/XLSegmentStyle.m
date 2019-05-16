//
//  XLSegmentStyle.m
//  ScrollPageDemo
//
//  Created by chenxl on 2019/5/16.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "XLSegmentStyle.h"

@implementation XLSegmentStyle
- (instancetype)init
{
    self = [super init];
    if (self) {
        _showLine = NO;
        _segmentHeight = 50;
        _titleFont = [UIFont systemFontOfSize:14.f];
        _selectedTitleColor = [UIColor redColor];
        _normalTitleColor = [UIColor blackColor];
        _scrollLineColor = [UIColor redColor];
        _scrollLineHeight = 2.f;
    }
    return self;
}
@end
