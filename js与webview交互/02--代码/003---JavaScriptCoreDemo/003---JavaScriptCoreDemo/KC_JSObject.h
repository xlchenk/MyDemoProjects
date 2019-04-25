//
//  KC_JSObject.h
//  003---JavaScriptCoreDemo
//
//  Created by Cooci on 2018/7/26.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol KCJSProtocol <JSExport>

JSExportAs(letJSImage, - (void)letShowImage:(NSString *)str);

JSExportAs(getSum, - (int)getSum:(int)num1 num2:(int)num2);

@end


@interface KC_JSObject : NSObject<KCJSProtocol>

@property (nonatomic, copy) NSString *name;

@end
