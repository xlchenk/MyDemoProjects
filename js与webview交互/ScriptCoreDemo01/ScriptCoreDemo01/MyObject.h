//
//  MyObject.h
//  ScriptCoreDemo01
//
//  Created by chenxl on 2019/4/26.
//  Copyright © 2019 chenxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol MyJSDelegate <JSExport>
JSExportAs(updateUI, -(NSString *)updateUIWithParm:(NSString *)parm type:(NSString *)type);
//JSExportAs(userName, );
@end

NS_ASSUME_NONNULL_BEGIN

@interface MyObject : NSObject<MyJSDelegate>

-(NSString *)updateUIWithParm:(NSString *)parm type:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
