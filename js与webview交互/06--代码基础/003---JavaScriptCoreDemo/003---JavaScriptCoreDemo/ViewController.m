//
//  ViewController.m
//  003---JavaScriptCoreDemo
//
//  Created by Cooci on 2018/7/26.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"
#import "JSCoreMoreVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation ViewController
- (IBAction)didClickLeftAction:(id)sender {
    [self.navigationController pushViewController:[JSCoreMoreVC new] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate        = self;
    [self.view addSubview:self.webView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

- (IBAction)didClickRightItemAction:(id)sender {
    NSLog(@"响应");
    [self.jsContext evaluateScript:@"ider = 123"];
}

#pragma mark - UIWebViewDelegate
// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *titlt = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = titlt;
    
    //JSContext就为其提供着运行环境 H5上下文
    JSContext *jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext = jsContext;
    
    // 异常处理
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"exception == %@",exception);
        NSLog(@"%@",context);
    };
    
    // 提供全局变量
    [self.jsContext evaluateScript:@"var arr = [3, 'Cooci', 'abc'];"];
    
    self.jsContext[@"showMessage"] = ^() {
        
        JSValue *thisValue = [JSContext currentThis];
        NSLog(@"thisValue = %@",thisValue);
        JSValue *cValue = [JSContext currentCallee];
        NSLog(@"cValue = %@",cValue);
        NSArray *args = [JSContext currentArguments];
        NSLog(@"来了:%@",args);
        
        NSDictionary *dict = @{@"name":@"cooci",@"age":@18};
        
        [[JSContext currentContext][@"ocCalljs"] callWithArguments:@[dict]];
    };
    

}



@end
