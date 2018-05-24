//
//  ZPWKWebView.m
//  ZPWKWebView
//
//  Created by 张鹏 on 2017/3/14.
//  Copyright © 2017年 张鹏. All rights reserved.
//

#import "ZPWKWebView.h"
#import "ZPScriptMessage.h"
@interface ZPWKWebView ()

@property (nonatomic, strong) NSURL *baseURL;

@end
@implementation ZPWKWebView

-(instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration{
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        if (configuration) {
            [configuration.userContentController addScriptMessageHandler:self name:@"webViewApp"];
        }
//        这句是关闭系统自带的侧滑后退功能
//        self.allowsBackForwardNavigationGestures = YES;
        self.baseURL = [NSURL URLWithString:@""];
    }
    return self;
}
#pragma mark - 加载网络页面

- (void)loadNetWorkHTMLWithURL:(nonnull NSString *)url{
    [self loadNetWorkHTMLWithURL:url params:nil];
}

- (void)loadNetWorkHTMLWithURL:(nonnull NSString *)url params:(nullable NSDictionary *)params{
    NSURL *urlStr = [self generateURL:url params:params];
    [self loadRequest:[NSURLRequest requestWithURL:urlStr]];
}
- (NSURL *)generateURL:(NSString *)baseURL params:(NSDictionary *)params{
    self.webViewRequestUrl = baseURL;
    self.webViewRequestParams = params;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSMutableArray *pairs = [NSMutableArray array];
    
    for (NSString *key  in param.keyEnumerator) {
        NSString *value = [NSString stringWithFormat:@"%@",[param objectForKey:key]];
        NSString *escaped_value = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)value, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", kCFStringEncodingUTF8);
        [pairs addObject:[NSString stringWithFormat:@"%@=%@",key,escaped_value]];
    }
    NSString *query = [pairs componentsJoinedByString:@"&"];
    baseURL = [baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = @"";
    if ([baseURL containsString:@"?"]) {
        url = [NSString stringWithFormat:@"%@&%@",baseURL,query];
    }else{
        url = [NSString stringWithFormat:@"%@?%@",baseURL,query];
    }
    //绝对地址
    if ([url.lowercaseString hasPrefix:@"http"]) {
        
        return [NSURL URLWithString:url];
    }else{
        return [NSURL URLWithString:url relativeToURL:self.baseURL];
    }
}
#pragma mark - 加载本地HTML

- (void)loadLocalHTMLWithFileName:(nonnull NSString *)name{
    NSString *path = [[NSBundle mainBundle]bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString *htmlPath = [[NSBundle mainBundle]pathForResource:name ofType:@"html"];
    NSString *htmlCOnt = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [self loadHTMLString:htmlCOnt baseURL:baseURL];
}
#pragma mark - View Method

- (void)reloadWebView{
    [self loadNetWorkHTMLWithURL:self.webViewRequestUrl params:self.webViewRequestParams];
}
#pragma mark - JS Method

- (void)callJS:(nonnull NSString *)jsMethod{
    [self callJS:jsMethod handler:nil];
}

- (void)callJS:(nonnull NSString *)jsMethod handler:(nullable void(^)(__nullable id response))handler{
    NSLog(@"call JS:%@",jsMethod);
    [self evaluateJavaScript:jsMethod completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (handler) {
            handler(response);
        }
    }];
}
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"message %@",message.body);
    if ([message.body isKindOfClass:[NSDictionary class]]) {
        NSDictionary *body = (NSDictionary *)message.body;
        ZPScriptMessage *msg = [ZPScriptMessage new];
        [msg setValuesForKeysWithDictionary:body];
        
        if (self.zp_messageHandlerDelegate && [self.zp_messageHandlerDelegate respondsToSelector:@selector(zp_webView:didReceiveScriptMessage:)]) {
            [self.zp_messageHandlerDelegate zp_webView:self didReceiveScriptMessage:msg];
        }
    }
}
@end
