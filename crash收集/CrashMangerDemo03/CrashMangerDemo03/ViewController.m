//
//  ViewController.m
//  CrashMangerDemo03
//
//  Created by chenxl on 2019/4/12.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#define FileDirectiory   [NSString stringWithFormat:@"%@/ExceptionManager", [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]]
#define FilePath  [NSString stringWithFormat:@"%@/Exception.txt", FileDirectiory]

@interface ViewController ()
@property(nonatomic,strong) NSArray * array;
@property(nonatomic,assign) int a;
@property(nonatomic,strong) NSDictionary * dict;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _array = @[@"xiao",@"lng",@"ww"];
    _dict = @{@"name":@"xiaom",@"age":@"123"};
    
    NSString *strFilePath = FilePath;
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:strFilePath];
    [fileHandle seekToEndOfFile];
}
-(void)test1{
    NSLog(@"%@",_array[11]);
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self test1];
//    NSString * sound = @"婆婆和嬷嬷，来到山坡坡，婆婆默默采蘑菇，嬷嬷默默拔萝卜。婆婆拿了一个破簸箕，嬷嬷带了一个薄笸箩，婆婆采了半簸箕小蘑菇，嬷嬷拔了一笸箩大萝卜。婆婆采了蘑菇换饽饽，嬷嬷卖了萝卜买馍馍。";
//    AVSpeechUtterance * utterance = [AVSpeechUtterance speechUtteranceWithString:sound];
//
//    utterance.pitchMultiplier = 1;
//
//    utterance.volume = 1;
//
//    utterance.rate = 0.55;
//    AVSpeechSynthesisVoice * voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
//    utterance.voice = voice;
//    NSLog(@"AVSpeechSynthesisVoice---%@",[AVSpeechSynthesisVoice speechVoices]);
//
//    AVSpeechSynthesizer * speech = [[AVSpeechSynthesizer alloc]init];
//    [speech speakUtterance:utterance]; //说话
}

@end
