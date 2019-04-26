//
//  ViewController.m
//  WKwebViewDemo01
//
//  Created by chenxl on 2019/4/26.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "HandleController.h"
@interface ViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (strong, nonatomic) WKWebView * webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
/**
 WKUserContentController: 提供使用 JavaScript post 信息和注射 script 的方法。
 WKScriptMessage: 包含网页发出的信息。
 WKUserScript: 表示可以被网页接受的用户脚本。
 WKWebViewConfiguration: 初始化 webview 的设置。
 
 WKNavigationDelegate: 提供了追踪主窗口网页加载过程和判断主窗口和子窗口是否进行页面加载新页面的相关方法。
 WKScriptMessageHandler: 提供从网页中收消息的回调方法。
 WKUIDelegate: 提供用原生控件显示网页的方法回调。
 */
    //初始化信息
NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
     WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];

    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    config.userContentController = wkUController;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:urlStr];
    [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
}

- (IBAction)leftBtnMethod:(id)sender {
    
}


- (IBAction)rightMethod:(id)sender {
    NSString *jsStr = [NSString stringWithFormat:@"showAlert('%@')",@"OC调用JS方法"];
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
        NSLog(@"%@",result);
    }];
}




#pragma mark -- delegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    NSString * methodName = URL.host;
    if ([scheme isEqualToString:@"cany"]) {
        if ([methodName isEqualToString:@"jsCallOC"]) {
            NSMutableDictionary *temDict = [self parameterWithURL:URL];
            NSString *username = [temDict objectForKey:@"username"];
            NSString *password = [temDict objectForKey:@"password"];
            NSLog(@"%@---%@",username,password);
        }
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
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


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");
}
#pragma mark - 解析URL地址
-(NSMutableDictionary *) parameterWithURL:(NSURL *) url {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    //回调遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parm setObject:obj.value forKey:obj.name];
    }];
    return parm;
}
@end
