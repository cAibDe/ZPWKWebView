//
//  ZPWKWebView.h
//  ZPWKWebView
//
//  Created by 张鹏 on 2017/3/14.
//  Copyright © 2017年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class ZPWKWebView;
@class ZPScriptMessage;

@protocol ZPWKWebViewMessageHandlerDelegate <NSObject>

@optional
- (void)zp_webView:(nonnull ZPWKWebView *)webView didReceiveScriptMessage:(nonnull ZPScriptMessage *)message;

@end
@interface ZPWKWebView : WKWebView<WKScriptMessageHandler,ZPWKWebViewMessageHandlerDelegate>
//加载页面的URL
@property (nullable, nonatomic, copy) NSString *webViewRequestUrl;
//webview 参数
@property (nullable, nonatomic, copy) NSDictionary *webViewRequestParams;

@property (nullable, nonatomic,weak) id<ZPWKWebViewMessageHandlerDelegate>zp_messageHandlerDelegate;

#pragma mark - 加载网络页面

- (void)loadNetWorkHTMLWithURL:(nonnull NSString *)url;

- (void)loadNetWorkHTMLWithURL:(nonnull NSString *)url params:(nullable NSDictionary *)params;
#pragma mark - 加载本地HTML

- (void)loadLocalHTMLWithFileName:(nonnull NSString *)name;

#pragma mark - View Method

- (void)reloadWebView;

#pragma mark - JS Method

- (void)callJS:(nonnull NSString *)jsMethod;

- (void)callJS:(nonnull NSString *)jsMethod handler:(nullable void(^)(__nullable id response))handler;

@end
