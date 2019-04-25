//
//  OCMockViewController.m
//  001---OCMock依赖注入
//
//  Created by Cooci on 2018/8/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//


#import "OCMockViewController.h"

@interface OCMockViewController ()

@end

@implementation OCMockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)updateIDCardView{
    
    NSArray *dogs = [self.manager fetchDogs];
    if (dogs != nil) {
        for (Dog *dog in dogs){
            [self.idCardView addDog:dog];
        }
    }
}

- (void)updateIDCardView2{
    
    NSArray *dogs = [Manager fetchDogs2];
    if (dogs != nil) {
        for (Dog *dog in dogs){
            [self.idCardView addDog:dog];
        }
    } 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
