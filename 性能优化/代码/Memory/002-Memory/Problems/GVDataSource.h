//
//  GVDataSource.h
//  002-Memory
//
//  Created by hzg on 2018/3/31.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

typedef void (^CellConfigureBlock)(id cell, id item, NSIndexPath *indexPath);

@interface GVDataSource : NSObject <UITableViewDataSource>

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)cellIdentifier
 configureCellBlock:(CellConfigureBlock)configureCellBlock;

- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)cellIdentifier
     tableViewStyle:(UITableViewCellStyle)tableViewStyle
 configureCellBlock:(CellConfigureBlock)configureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) NSArray* items;
@property (nonatomic, copy) NSString* cellIdentifier;
@property (nonatomic, copy) CellConfigureBlock configureCellBlock;
@property (assign, nonatomic) UITableViewCellStyle tableViewStyle;

@end

