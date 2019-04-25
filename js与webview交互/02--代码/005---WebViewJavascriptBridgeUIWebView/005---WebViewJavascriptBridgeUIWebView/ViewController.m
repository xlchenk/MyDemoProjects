//
//  ViewController.m
//  005---WebViewJavascriptBridgeUIWebView
//
//  Created by Cooci on 2018/7/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"
#import <WebViewJavascriptBridge.h>

@interface ViewController ()<WebViewJavascriptBridgeBaseDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *wjb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    
    self.wjb = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    // 如果你要在VC中实现 UIWebView的代理方法 就实现下面的代码(否则省略)
    [self.wjb setWebViewDelegate:self];
    
    [self.wjb registerHandler:@"jsCallsOC" handler:^(id data, WVJBResponseCallback responseCallback) {
       
        NSLog(@"data == %@ -- %@",data,responseCallback);
    }];
}


- (IBAction)didClickLetfAction:(id)sender {
    
    [self.wjb callHandler:@"OCCallJSFunction" data:@"occalljs" responseCallback:^(id responseData) {
       
        NSLog(@"responseData == %@",responseData);
    }];
    
}
- (IBAction)didClickRightAction:(id)sender {
    NSLog(@"响应按钮");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
