//
//  CrashHandlerManager.m
//  CrashMangerDemo03
//
//  Created by chenxl on 2019/4/12.
//  Copyright © 2019 chenxl. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CrashHandlerManager.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import <mach-o/dyld.h>

#define FileDirectiory [NSString stringWithFormat:@"%@/ExceptionFile",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]]
#define FilePath  [NSString stringWithFormat:@"%@/CrashContent.txt", FileDirectiory]

NSString * const UncaughtExceptionHandlerSignalExceptionName= @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const SignalValue = @"SignalValue";

@implementation CrashHandlerManager
/** 打开初始化Exception捕获的功能 */
+(void)openExceptionManager{
    //  参数为异常处理方法的函数指针
//    void NSSetUncaughtExceptionHandler(NSUncaughtExceptionHandler * _Nullable);
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);

    //捕获unix信号抓到得异常
    signal(SIGABRT, handleSignalHandler); //注册程序由于abort()函数调用发生的程序中止信号
    signal(SIGILL, handleSignalHandler); //注册程序由于非法指令产生的程序中止信号
    signal(SIGSEGV, handleSignalHandler); //注册程序由于无效内存的引用导致的程序中止信号
    signal(SIGFPE, handleSignalHandler); //注册程序由于浮点数异常导致的程序中止信号
    signal(SIGBUS, handleSignalHandler); //注册程序由于内存地址未对齐导致的程序中止信号
    signal(SIGPIPE, handleSignalHandler); //程序通过端口发送消息失败导致的程序中止信号
    
}


#pragma mark -- 当异常退出的时候   可以做些自定义的事情
void uncaughtExceptionHandler(NSException *exception){
   NSString * crashContent = [CrashHandlerManager getBacktraceStackInfo];
     // 把监听都置空
    NSSetUncaughtExceptionHandler(NULL);
    [[[CrashHandlerManager alloc]init] performSelector:@selector(saveCrashInfoToFile:exception:) withObject:crashContent withObject:exception];
}
#pragma mark -- Signal处理方法
void handleSignalHandler(int signal){
    NSString * crashContent = [CrashHandlerManager getBacktraceStackInfo];//获取信息
    NSString * reason = [NSString stringWithFormat:NSLocalizedString(@"Signal %d was raised.\n"
                                                                    @"%@", nil),
                        signal, getAppInfo()];
    
    NSException * exception = [NSException exceptionWithName: UncaughtExceptionHandlerSignalExceptionName
                                                      reason:reason userInfo:@{@"crashContent":crashContent,@"signalValue":SignalValue}];
   
    [[[CrashHandlerManager alloc]init] performSelectorOnMainThread:@selector(handleException:) withObject:exception waitUntilDone:YES];
}
#pragma mark -- 异常处理
-(void)handleException:(NSException *)exception{
    NSDictionary * userInfo = [exception userInfo];
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
     [self saveCrashInfoToFile:userInfo exception:exception];
    //要kill掉
    if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName]){
        kill(getpid(), [[[exception userInfo] objectForKey:SignalValue] intValue]);
    }else{
        [exception raise];
    }
}
-(void)saveCrashInfoToFile:(NSDictionary *)crashInfo exception:(NSException *)exception{
    if (crashInfo == nil) {
        return;
    }
    NSLog(@"Crash: %@", exception);
    NSLog(@"StackTraceInfo: %@", [exception callStackSymbols]);
    NSLog(@"FilePath-->%@",FilePath);
    
    NSString * crashContent = [NSString stringWithFormat:@"ExceptionInfo: ( Time : %@ )\nname:%@ \n reason:%@ \n callStackSymbols:\n%@ \n",
     getCrashDate(),
     exception.name,
     exception.reason,
     (exception.callStackSymbols!=nil)?exception.callStackSymbols.description : @""];
    crashContent = [crashContent stringByAppendingString:getAppInfo()];
    crashContent = [crashContent stringByAppendingString:@"\n\n"];

    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:FileDirectiory]) {
        BOOL success = [fileManager createDirectoryAtPath:FileDirectiory withIntermediateDirectories:YES attributes:nil error:nil];
        if (!success) { return; } //创建失败就return
    }
    NSString *strFilePath = FilePath;
    if (![fileManager fileExistsAtPath:strFilePath]) {
        BOOL success = [fileManager createFileAtPath:strFilePath contents:nil attributes:nil];
        if (!success) { return;}
    }
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:strFilePath];
    [fileHandle seekToEndOfFile];
    NSData * data = [crashContent dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        [fileHandle closeFile];
        return;
    }
    [fileHandle writeData:data];
    [fileHandle closeFile];
    fileHandle = nil;
}
#pragma mark -- 获取函数堆栈信息
+ (NSString *)getBacktraceStackInfo{
    long long sildeAddress =  getSlideAddress();
    NSString *strSildeAddress = getHEXAddress(sildeAddress);
    
    NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey]; //获取项目名称
    NSString *strDate = getCrashDate();
    NSMutableString *muStrContent = [NSMutableString new];
     [muStrContent appendFormat:@"%@ - ( Time ：%@ ) \nSildeAddress - %@\n", executableFile, strDate,strSildeAddress];
    void* callstack[128];
    int frames = backtrace(callstack, 128);//用于获取当前线程的函数调用堆栈，返回实际获取的指针个数
    char **strs = backtrace_symbols(callstack, frames);//从backtrace函数获取的信息转化为一个字符串数组
    int i;
    NSMutableString *muStrValue = [NSMutableString new];
    
    for (i = 0;i <frames;i++){
        NSString *strTemp = [NSString stringWithUTF8String:strs[i]];
        if(strTemp == nil || [strTemp isEqualToString:@""] == YES) {
            continue;
        }
        [muStrValue appendFormat:@"%@\n", strTemp];
    }
    free(strs);
    if((muStrValue != nil) && (![muStrValue isEqualToString:@""])){
        [muStrContent appendString:muStrValue];
    }
     [muStrContent appendString:@"\n\n"];
    
    return [muStrContent copy];
}
#pragma mark -- 获取应用信息
NSString* getAppInfo(){
    NSString *appInfo = [NSString stringWithFormat:@"App : %@ %@(%@)\nDevice : %@\nOS Version : %@ %@\nUDID: %@\n",
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                         [UIDevice currentDevice].model,
                         [UIDevice currentDevice].systemName,
                         [UIDevice currentDevice].systemVersion,
                         [UIDevice currentDevice].identifierForVendor
                         ];
    
    NSLog(@"Crash!!!! %@", appInfo);
    return appInfo;
}

/**
 因为iOS采用了ASLR（Address space layout randomization），ASDL机制会在app加载时根据load address动态加一个偏移地址slide address。所以在捕获错误地址stack address后，需要减去偏移地址才能得到正确的符号地址symbol address，上面我们从异常信息提取到的地址0x0000000102ff1f94 是stack address。额，简单说，dSYM里面存储的是一张连续的内存地址表（0~10），但是iOS 运行时从中拿了一部分（3~5），然后加载到一个起始内存地址为20的内存块中，那么我们从异常信息中提取到的内存地址是 （23 ~ 25），这样是无法映射到dSYM表（0~10）中，就需要减去一个偏移量（就是起始内存地址20），之后才可以在dSYM表中找到该代码的位置了
 */
#pragma mark -- 获取加载偏移地址
long long getSlideAddress(){
    long long slide = 0;
    for (uint32_t i = 0; i < _dyld_image_count(); i++) {
        if (_dyld_get_image_header(i)->filetype == MH_EXECUTE) {
            slide = _dyld_get_image_vmaddr_slide(i);
            break;
        }
    }
    return slide;
}

#pragma mark -- 获取16进制
NSString * getHEXAddress(long long address){
    NSString *strResult = [NSString stringWithFormat:@"0x%02llx", address];
    return strResult;
}
NSString *getCrashDate(){
    static NSDateFormatter * dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return [dateFormatter stringFromDate:[NSDate date]];
}

@end
