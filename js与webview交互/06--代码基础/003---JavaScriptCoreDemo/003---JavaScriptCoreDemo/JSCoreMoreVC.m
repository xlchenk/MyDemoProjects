//
//  JSCoreMoreVC.m
//  003---JavaScriptCoreDemo
//
//  Created by Cooci on 2018/7/26.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "JSCoreMoreVC.h"
#import "KC_JSObject.h"

@interface JSCoreMoreVC ()<UIWebViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UILabel *showLabel;
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic,strong) UIImagePickerController *imagePicker;

@end

@implementation JSCoreMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.showLabel];

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 124, self.view.bounds.size.width, self.view.bounds.size.height-124)];
    self.webView.delegate        = self;
    [self.view addSubview:self.webView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index2.html" withExtension:nil];;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点我" style:UIBarButtonItemStyleDone target:self action:@selector(didClickRightAction)];
    
    
}

- (void)didClickRightAction{
    
    NSLog(@"rightBarButtonItem");
}

#pragma mark - UIWebViewDelegate
// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *titlt = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = titlt;
    
    //JSContext就为其提供着运行环境 H5上下文
    JSContext *jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext = jsContext;
    __weak typeof(self) weakSelf = self;

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
    
    // 因为是全局变量 可以直接获取
    JSValue *arrValue = self.jsContext[@"arr"];
    NSLog(@"arrValue == %@",arrValue);
    
    //纠正用法
//    JSValue *value = [JSValue valueWithObject:@"test“ inContext:context];
//    JSManagedValue *managedValue = [JSManagedValue managedValueWithValue:value andOwner:self];

    
    self.jsContext[@"showDict"] = ^(JSValue *value) {
        
        NSArray *args = [JSContext currentArguments];
        JSValue *dictValue = args[0];
        NSDictionary *dict = dictValue.toDictionary;
        NSLog(@"%@",dict);
        
        // 模拟用
        int num = [[arrValue.toArray objectAtIndex:0] intValue];
        num += 10;
        NSLog(@"arrValue == %@   num == %d",arrValue.toArray,num);
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.showLabel.text = dict[@"name"];
        });
    };
    
    
    //异常收集
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        weakSelf.jsContext.exception = exception;
        NSLog(@"exception == %@",exception);
    };
    
    
    // JS 操作对象
    KC_JSObject *kcObject = [[KC_JSObject alloc] init];
    self.jsContext[@"kcObject"] = kcObject;
    

    // 打开相册
    self.jsContext[@"getImage"] = ^() {
        
        weakSelf.imagePicker = [[UIImagePickerController alloc] init];
        weakSelf.imagePicker.delegate = weakSelf;
        weakSelf.imagePicker.allowsEditing = YES;
        weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [weakSelf presentViewController:weakSelf.imagePicker animated:YES completion:nil];
    };
    
}

- (void)dealloc{
    NSLog(@"dealloc :走了");
}

#pragma mark -- UIImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"info---%@",info);
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSData *imgData = UIImageJPEGRepresentation(resultImage, 0.01);
    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [self removeSpaceAndNewline:encodedImageStr];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *imageString = [self removeSpaceAndNewline:encodedImageStr];
    NSString *jsFunctStr = [NSString stringWithFormat:@"showImage('%@')",imageString];
    [self.jsContext evaluateScript:jsFunctStr];
}

- (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}


- (void)openAlbum{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

#pragma mark - lazy

- (UILabel *)showLabel{
    if (!_showLabel) {
        _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 64+20, 100, 30)];
        _showLabel.textColor = [UIColor orangeColor];
        _showLabel.font = [UIFont systemFontOfSize:16];
        _showLabel.text = @"我是一个文本";
    }
    return _showLabel;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
