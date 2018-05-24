//
//  ZPScriptMessage.m
//  ZPWKWebView
//
//  Created by 张鹏 on 2017/3/14.
//  Copyright © 2017年 张鹏. All rights reserved.
//

#import "ZPScriptMessage.h"

@implementation ZPScriptMessage

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@:{method:%@,params:%@,callback:%@}>",NSStringFromClass([self class]),self.method,self.params,self.callback];
}
@end
