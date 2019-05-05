//
//  ViewController.m
//  轮播
//
//  Created by chenxl on 2019/4/29.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"
#import "CLCycleView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
    CLCycleView * cycle = [[CLCycleView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200)];
//    cycle.backgroundColor = [UIColor redColor];
//    
    cycle.imageArray = @[@"home_banner01",@"home_banner02",@"home_banner03",@"home_banner04"];
    [self.view addSubview:cycle];
    
 
}






//-(UIScrollView *)scrollView{
//    if (_scrollView == nil) {
//        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 300)];
//        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _scrollView.delegate = self;
//        _scrollView.pagingEnabled = YES;
//        _scrollView.backgroundColor = [UIColor greenColor];
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.decelerationRate = 1.0;
//        _scrollView.contentOffset = CGPointMake(0, 0);
//        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3,0);
//    }
//    return _scrollView;
//}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//
//
//}
//#pragma mark -- 拖拽停止NSTimer
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//
//
//
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//
//
//}

@end
