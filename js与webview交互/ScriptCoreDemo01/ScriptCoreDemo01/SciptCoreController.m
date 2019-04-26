//
//  SciptCoreController.m
//  ScriptCoreDemo01
//
//  Created by chenxl on 2019/4/26.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "SciptCoreController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MyObject.h"
@interface SciptCoreController ()<UIWebViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic,strong) UIImagePickerController *imagePicker;

@end

@implementation SciptCoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //协议的方法交互
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 124, self.view.bounds.size.width, self.view.bounds.size.height-124)];
    self.webView.delegate        = self;
    [self.view addSubview:self.webView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index2.html" withExtension:nil];;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"按钮" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightMethod)];


}

-(void)clickRightMethod{
    
}

#pragma mark - UIWebViewDelegate
// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    __weak typeof(self) weakSelf = self;
    
   self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"initImagePicker"] = ^(){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        weakSelf.imagePicker = [[UIImagePickerController alloc]init];
        weakSelf.imagePicker.delegate = strongSelf;
        weakSelf.imagePicker.allowsEditing = YES;
        weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [weakSelf presentViewController:weakSelf.imagePicker animated:YES completion:^{
            NSLog(@"4444444");
        }];
    };
    
    //JS操作OC对象 调OC对象方法
    MyObject * obj = [[MyObject alloc]init];
    
    self.jsContext[@"jsObject"] = obj;
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSData *imgData = UIImageJPEGRepresentation(resultImage, 0.01);
    NSString *basse64ImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    basse64ImageStr = [self removeSpaceAndNewline:basse64ImageStr];
    [self dismissViewControllerAnimated:YES completion:nil];
   
    //执行JS方法 更新H5UI
//    NSString *jsFunctStr = [NSString stringWithFormat:@"showImage('%@')",basse64ImageStr];
//    [self.jsContext evaluateScript:jsFunctStr];
//    [[JSContext currentContext][@"showImage"] callWithArguments:@[basse64ImageStr]];
    
    JSValue * function = [self.jsContext objectForKeyedSubscript:@"showImage"];
    [function callWithArguments:@[basse64ImageStr]];
    
}

- (NSString *)removeSpaceAndNewline:(NSString *)str{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}


@end
