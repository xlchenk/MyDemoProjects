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

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate>
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
 
    // JS-->OC
    self.wjb = [WebViewJavascriptBridge  bridgeForWebView:self.webView];
    [self.wjb setWebViewDelegate:self];
    [self.wjb  registerHandler:@"jsCallsOC" handler:^(id data, WVJBResponseCallback responseCallback) {
       
        NSLog(@"%@---%@----%@",[NSThread currentThread],data,responseCallback);
    }];
}

- (IBAction)didClickLeftAction:(id)sender {
    
    [self.wjb callHandler:@"OCCallJSFunction" data:@"糊涂蛋" responseCallback:^(id responseData) {
       
        NSLog(@"%@--%@",[NSThread currentThread],responseData);
    }];

}
- (IBAction)didClickRightAction:(id)sender {
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
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
