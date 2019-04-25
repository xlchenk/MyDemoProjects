//
//  ViewController.m
//  WebViewDemo01
//
//  Created by chenxl on 2019/4/24.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

}
//OC调用JS方法

/**
  - (nullable NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;
  UIWebview自带的一个方法
 */
- (IBAction)rightClickMethod:(id)sender {
    //1、可以直接调用js方法
//    NSString * str = [self.webView stringByEvaluatingJavaScriptFromString:@"OCInvokeJSMethodAlert('hello 你好')"];
//    NSLog(@"----%@",str);
//    2、也可以执行多行代码
    [self.webView stringByEvaluatingJavaScriptFromString:@"var div = document.getElementById('square'); div.style.background = 'green';"];

}

-(void)respondHTMLMethod:(NSString *)message{
   
//    NSString * str = [self.webView stringByEvaluatingJavaScriptFromString:@"showAlert('sldjfljl')"];
//    NSLog(@"----%@",str);
    NSLog(@"dfsa23423%@",message);
}

#pragma mark -- delegate
//开始加载所有的请求数据
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //js调用OC的方法 核心 ：拦截js传过来的方法 然后转换OC的方法实现
    NSString * scheme = request.URL.scheme;
    NSString * methodName = request.URL.host;
    NSArray * parms = request.URL.pathComponents;
    
    NSLog(@"URL.scheme-%@",scheme);//自己定义的一个表示
    NSLog(@"URL.host-%@",methodName);//方法名称
    NSLog(@"request.URL.path-%@",request.URL.path);
    NSLog(@"pathComponents--%@",parms);
    //三中方法实现
    //1、判断scheme名称
   
    if ([scheme isEqualToString:@"cany"]) {
        if ([methodName isEqualToString:@"respondHTMLMethod"]) {
            [self respondHTMLMethod:parms[1]];
        }
    }
    
    
    return YES;
}
//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载");
}
//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *titlt = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = titlt;
    
   
    NSLog(@"加载完成了!!!!");
}
//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
     NSLog(@"加载失败了咯,为什么:%@",error);
}
@end
