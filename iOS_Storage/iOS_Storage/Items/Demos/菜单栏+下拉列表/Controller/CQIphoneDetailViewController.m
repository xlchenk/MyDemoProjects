//
//  CQIphoneDetailViewController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQIphoneDetailViewController.h"

@interface CQIphoneDetailViewController ()

@property (nonatomic, strong) IphoneListItemModel *model;

@end

@implementation CQIphoneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.model.name;
}

- (instancetype)initWithModel:(IphoneListItemModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

@end
