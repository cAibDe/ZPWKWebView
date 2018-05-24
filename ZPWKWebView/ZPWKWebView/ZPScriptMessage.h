//
//  ZPScriptMessage.h
//  ZPWKWebView
//
//  Created by 张鹏 on 2017/3/14.
//  Copyright © 2017年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
//WKWebView与JS调用时参数规范实体
@interface ZPScriptMessage : NSObject
//与前端协商的方法名，到时候根据方法名做页面的相关操作
@property (nonatomic, copy) NSString *method;
//JS传来的参数
@property (nonatomic, copy) NSDictionary *params;
//回调函数名 nativeAPP执行完回调JS方法
@property (nonatomic, copy) NSString *callback;
@end
