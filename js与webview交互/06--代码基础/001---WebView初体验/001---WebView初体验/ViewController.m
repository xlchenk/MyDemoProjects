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
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - private

- (void)getSum:(NSString *)parm{

    NSLog(@"123344444");
    NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:@"showAlert('HELLO')"];
    NSLog(@"result == %@",result);
}

#pragma mark - 响应

- (IBAction)didClickLetfAction:(id)sender {
    
}
- (IBAction)didClickRightItemClick:(id)sender {
    NSLog(@"响应按钮");
    NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:@"showAlert('HELLO')()"];
    NSLog(@"result == %@",result);
}

#pragma mark - UIWebViewDelegate

/**
 这些都是JS响应的样式
 UIWebViewNavigationTypeLinkClicked,        点击
 UIWebViewNavigationTypeFormSubmitted,      提交
 UIWebViewNavigationTypeBackForward,        返回
 UIWebViewNavigationTypeReload,             刷新
 UIWebViewNavigationTypeFormResubmitted,    重复提交
 UIWebViewNavigationTypeOther               其他

 */
// 加载所有请求数据,以及控制是否加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"%@",request.URL.scheme); // 标识 我们自己协议
    NSLog(@"%@",request.URL.host);   // 方法名
    NSLog(@"%@",request.URL.pathComponents);  // 参数

    // JS 调用OC 的原理就是 拦截URL
    NSString *scheme = request.URL.scheme;
    if ([scheme isEqualToString:@"tzedu"]) {
        NSLog(@"来了,我们自定义的协议");
        
        NSArray *args = request.URL.pathComponents;
        NSString *methodName = args[1];
        
        // 方法1
//        if ([methodName isEqualToString:@"getSum"]) {
//            [self getSum];
//        }
        // 方法2
        SEL methodSel = NSSelectorFromString(methodName);
        if ([self respondsToSelector:methodSel]) {
#pragma clang diagnostic push
            // 让编译器忽略错误
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            // 让编译器出栈，恢复状态，继续编译后续的代码！
            [self performSelector:methodSel withObject:args[2]];
#pragma clang diagnostic pop
        }
        // 方法3
//        objc_msgSend(self,methodSel,args[2],args[3]);
        
//        ((void (*) (id, SEL, id))(objc_msgSend))(self, methodSel,args[2]);
//
//        // 定义kc_msgSend 函数指针  (void *) 替代了 (void (*)(id, SEL, id))
//        void (*kc_msgSend) (id, SEL, id) = (void *)objc_msgSend;
//        kc_msgSend(self,methodSel,args[2]);
//
        return NO;
    }
    
    return YES;
}

// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"****************华丽的分界线****************");
    NSLog(@"开始加载咯!!!!");
}

// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *titlt = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = titlt;
    
    NSLog(@"****************华丽的分界线****************");
    NSLog(@"加载完成了咯!!!!");
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
