//
//  ViewController.m
//  CrashMangerDemo02
//
//  Created by chenxl on 2019/4/11.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) NSArray * array;
@property(nonatomic,assign) int a;
@property(nonatomic,strong) NSDictionary * dict;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //void    (*signal(int, void (*)(int)))(int);
//    signal(<#int#>, <#void (*)(int)#>)
    _array = @[@"xiao",@"lng",@"ww"];
    _dict = @{@"name":@"xiaom",@"age":@"123"};
}
-(void)test1{
        NSLog(@"%@",_array[3]);
 
}
-(void)tee{
    /**
     0   CoreFoundation                      0x00000001043d61bb __exceptionPreprocess + 331,
     1   libobjc.A.dylib                     0x0000000103974735 objc_exception_throw + 48,
     2   CoreFoundation                      0x00000001043224ec _CFThrowFormattedException + 194,
     3   CoreFoundation                      0x0000000104458b00 +[__NSArrayI allocWithZone:] + 0,
     4   CrashMangerDemo02                   0x000000010305215e -[ViewController test1] + 62,
     5   CrashMangerDemo02                   0x00000001030521ea -[ViewController touchesBegan:withEvent:] + 90,
     6   UIKitCore                           0x000000010726a8e8 forwardTouchMethod + 353,
     7   UIKitCore                           0x000000010726a776 -[UIResponder touchesBegan:withEvent:] + 49,
     8   UIKitCore                           0x0000000107279dff -[UIWindow _sendTouchesForEvent:] + 2052,
     9   UIKitCore                           0x000000010727b7a0 -[UIWindow sendEvent:] + 4080,
     10  UIKitCore                           0x0000000107259394 -[UIApplication sendEvent:] + 352,
     11  UIKitCore                           0x000000010732e5a9 __dispatchPreprocessedEventFromEventQueue + 3054,
     12  UIKitCore                           0x00000001073311cb __handleEventQueueInternal + 5948,
     13  CoreFoundation                      0x000000010433b721 __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 17,
     14  CoreFoundation                      0x000000010433af93 __CFRunLoopDoSources0 + 243,
     15  CoreFoundation                      0x000000010433563f __CFRunLoopRun + 1263,
     16  CoreFoundation                      0x0000000104334e11 CFRunLoopRunSpecific + 625,
     17  GraphicsServices                    0x000000010c9ce1dd GSEventRunModal + 62,
     18  UIKitCore                           0x000000010723d81d UIApplicationMain + 140,
     19  CrashMangerDemo02                   0x0000000103052400 main + 112,
     20  libdyld.dylib                       0x0000000105d4a575 start + 1,
     21  ???                                 0x0000000000000001 0x0 + 1
     )
     */
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self test1];
}

@end
