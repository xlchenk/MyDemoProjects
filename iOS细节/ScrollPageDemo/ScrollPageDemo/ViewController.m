//
//  ViewController.m
//  ScrollPageDemo
//
//  Created by chenxl on 2019/5/13.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"
#import "SecondController.h"
#import "XLSocollPageView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGTH [UIScreen mainScreen].bounds.size.height

#define RgbColor(r,g,b,a) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:a]
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self test];
}
-(void)test{
     NSArray *titles = @[@"餐宴网",@"饿了么",@"美团",@"百度外卖",@"农夫山泉",@"富士康",@"美丽天津",@"梅江会展",@"小程序"];
    
    NSMutableArray * vcArray = [NSMutableArray array];
        for (NSString *title in titles) {
            SecondController *vc = [SecondController new];
            vc.title = title;
            [vcArray addObject:vc];
        }
    XLSegmentStyle * style = [[XLSegmentStyle alloc]init];
    style.showLine = YES;
    style.titleFont = [UIFont systemFontOfSize:17];
    style.segmentHeight = 44;
    XLSocollPageView *pageView = [[XLSocollPageView alloc]initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) titles:titles segementStyle:style childVCs:vcArray parentViewController:self];
   
    
    //头部背景颜色
    pageView.headerBackGroundColor = [UIColor whiteColor];
    
    [self.view addSubview:pageView];
}

@end
