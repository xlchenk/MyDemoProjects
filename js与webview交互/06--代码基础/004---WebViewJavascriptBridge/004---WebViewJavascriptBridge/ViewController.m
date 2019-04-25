//
//  ViewController.m
//  004---WebViewJavascriptBridge
//
//  Created by Cooci on 2018/7/27.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"
#import <WebViewJavascriptBridge.h>
#import <WebKit/WebKit.h>

@interface ViewController ()<WKUIDelegate>
@property (strong, nonatomic) WKWebView   *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *wjb;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    configuration.userContentController = wkUController;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:urlStr];
    [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    
    self.wjb = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    // 如果你要在VC中实现 UIWebView的代理方法 就实现下面的代码(否则省略)
     [self.wjb setWebViewDelegate:self];
    
    [self.wjb registerHandler:@"jsCallsOC" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSLog(@"currentThread == %@",[NSThread currentThread]);
        
        NSLog(@"data == %@ -- %@",data,responseCallback);
    }];

    
}

- (IBAction)didClickLeftAction:(id)sender {
    
    //    // 如果不需要参数，不需要回调，使用这个
    //    [self.wjb callHandler:@"OCCallJSFunction"];
    //    // 如果需要参数，不需要回调，使用这个
    //    [self.wjb callHandler:@"OCCallJSFunction" data:@"一个字符串"];
    // 如果既需要参数，又需要回调，使用这个
    [self.wjb callHandler:@"OCCallJSFunction" data:@"oc调用JS咯" responseCallback:^(id responseData) {
        
        NSLog(@"currentThread == %@",[NSThread currentThread]);

        NSLog(@"调用完JS后的回调：%@",responseData);
    }];
}
- (IBAction)didClickRightAction:(id)sender {
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
