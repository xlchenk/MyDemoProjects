//
//  ViewController.m
//  ScriptCoreDemo01
//
//  Created by chenxl on 2019/4/26.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;


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
- (IBAction)clickRightMethod:(id)sender {
    JSValue * function = [self.jsContext objectForKeyedSubscript:@"showUserMessage"];
  JSValue * result = [function callWithArguments:@[@"wanxiaom",@"13",@"02"]];
    NSLog(@"showUserMessage----%@",result.context);

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载完成");
    /**
     JSContext：给JavaScript提供运行的上下文环境
     JSValue：JavaScript和Objective-C数据和方法的桥梁
     JSManagedValue：管理数据和方法的类
     JSVirtualMachine：处理线程相关，使用较少
     JSExport：这是一个协议，如果采用协议的方法交互，自己定义的协议必须遵守此协议
     JSContext是一个JS的执行环境，所有的JS执行都发生在一个context里面， 所有的JS value都绑定到context里面
     具体使用
     */
    //初始化context
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //js调OC方法
    self.jsContext[@"showEatFood"] = ^(NSArray * foodArray){
        NSLog(@"%@",[NSThread currentThread]);
        JSValue * currentThis = [JSContext currentThis];
        NSLog(@"currentThis--%@",currentThis);
        JSValue * currentCallee = [JSContext currentCallee];
        NSLog(@"currentCallee--%@",currentCallee);
        NSArray * currentArguments = [JSContext currentArguments];
        NSLog(@"currentArguments--%@",currentArguments);

        NSLog(@"foodArray -- %@",foodArray);
       //数据传给H5
        NSDictionary *dict = @{@"name":@"wangxiaom",@"age":@(111)};
        [[JSContext currentContext][@"callBlockInfo"] callWithArguments:@[dict]];
    };
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"加载失败");
}


@end
