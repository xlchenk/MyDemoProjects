//
//  ViewController.m
//  001---WebView初体验
//
//  Created by Cooci on 2018/7/25.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    // webView http 2.0 12.0 性能不佳   WK webKit 内核 操作要多一些 配置
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    NSURLRequest *reqeust = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:reqeust];
    
}

#pragma mark - private

- (void)getSum:(NSString *)str{

    NSLog(@"123344444 %@",str);
    
    NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:@"showAlert('HELLO')"];
    NSLog(@"result == %@",result);
}

- (void)getPlus{
    
    NSLog(@"getPlus");
    
    NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:@"showAlert('HELLO')"];
    NSLog(@"result == %@",result);
}

#pragma mark - 响应

- (IBAction)didClickLetfAction:(id)sender {
    
}


- (IBAction)didClickRightItemClick:(id)sender {
    NSLog(@"响应按钮");
    // OC --> JS
   NSLog(@"%@",[self.webView stringByEvaluatingJavaScriptFromString:@"showAlert('mumu')"]);
    
}

#pragma mark - UIWebViewDelegate

// 加载所有请求数据,以及控制是否加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    // request : host + 路由  : 拦截
    if ([request.URL.scheme isEqualToString:@"tzedu"]) {
        
        NSArray *paths = request.URL.pathComponents;
        NSString *routerName = request.URL.host;
        SEL methodSEL = NSSelectorFromString(routerName);
        
        if ([self respondsToSelector:methodSEL]) {
            
            objc_msgSend(self,methodSEL,@"1234");

//            [self performSelector:methodSEL withObject:nil afterDelay:0];
            
        }else{
            NSLog(@"没有相应路由");
        }
        
        return NO;
    }

    return YES;
}

// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"****************华丽的分界线****************");
    NSLog(@"开始加载咯!!!!");
    // tittle progress
}

// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{

    NSLog(@"****************华丽的分界线****************");
    NSLog(@"加载完成了咯!!!!");
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    self.title = title;
}

// 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"****************华丽的分界线****************");
    NSLog(@"加载失败了咯,为什么:%@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
