//
//  ViewController.m
//  Image圆绘制
//
//  Created by chenxl on 2019/5/8.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Circle.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:iv];
    UIImage * image = [UIImage imageNamed:@"header"];
 
    [image XL_cornerRadiusWithSize:iv.bounds.size fillColor:[UIColor whiteColor] completion:^(UIImage * image) {
        iv.image = image;
    }];
}


@end
