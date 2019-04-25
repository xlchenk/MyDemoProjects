//
//  OCMockViewController.h
//  001---OCMock依赖注入
//
//  Created by Cooci on 2018/8/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manager.h"
#import "IDCardView.h"

@interface OCMockViewController : UIViewController

@property(nonatomic, strong) Manager *manager;
@property(nonatomic, strong) IDCardView *idCardView;

- (void)updateIDCardView;

- (void)updateIDCardView2;

@end
