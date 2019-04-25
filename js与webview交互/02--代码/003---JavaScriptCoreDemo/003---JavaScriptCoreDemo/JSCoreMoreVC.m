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
    
    [self.jsContext evaluateScript:@"xiixhah()"];
    
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
    
    // 提供全局变量
    [self.jsContext evaluateScript:@"var arr = [3, 'Cooci', 'abc'];"];
    
    self.jsContext[@"showMessage"] = ^() {
        
        JSValue *thisValue = [JSContext currentThis];
        NSLog(@"thisValue = %@",thisValue);
        JSValue *cValue = [JSContext currentCallee];
        NSLog(@"cValue = %@",cValue);
        NSArray *args = [JSContext currentArguments];
        NSLog(@"来了:%@",args);
        
        NSDictionary *dict = @{@"name":@"Cooci",@"age":@"19"};
        
        [[JSContext currentContext][@"ocCalljs"] callWithArguments:@[dict]];
        
    };
    
    
    // 异常收集
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {

        NSLog(@"%@",exception);
    };

    
    // JS 操作OC对象
    KC_JSObject *obj = [KC_JSObject new];
    self.jsContext[@"kcObject"] = obj;

    // 打开相册
    
    self.jsContext[@"getImage"] = ^{
        // RAC
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = YES;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:^{
            NSLog(@"打开了");
        }];
        
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
