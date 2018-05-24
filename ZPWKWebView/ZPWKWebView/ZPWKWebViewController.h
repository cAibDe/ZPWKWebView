//
//  ZPWKWebViewController.h
//  ZPWKWebView
//
//  Created by 张鹏 on 2017/3/14.
//  Copyright © 2017年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPWKWebView.h"
#import "ZPScriptMessage.h"

@interface ZPWKWebViewController : UIViewController<ZPWKWebViewMessageHandlerDelegate,WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) ZPWKWebView *webView;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) BOOL showHUDWhenLoading;

@property (nonatomic, assign) BOOL shouldShowProgress;

@property (nonatomic, assign) BOOL isUseWebTitle;

@property (nonatomic, assign) BOOL scrollEnabled;

@end
