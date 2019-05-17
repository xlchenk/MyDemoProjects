//
//  SecondController.m
//  ScrollPageDemo
//
//  Created by chenxl on 2019/5/15.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "SecondController.h"
#import "XLSrollPageView/XLScrollViewChildVCDelegate.h"
@interface SecondController ()<UITableViewDelegate,UITableViewDataSource,XLScrollViewChildVCDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"哈喽--%ld",indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}
- (void)xl_viewDidAppearForIndex:(NSInteger)index{
    NSLog(@"自控制器---%ld",index);
    
}
@end
