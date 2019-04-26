//
//  HandleController.m
//  WKwebViewDemo01
//
//  Created by chenxl on 2019/4/26.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "HandleController.h"
#import <WebKit/WebKit.h>
@interface HandleController ()<WKNavigationDelegate,WKUIDelegate>
@property(nonatomic,strong) WKWebView *webView;
@end

@implementation HandleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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



@end
