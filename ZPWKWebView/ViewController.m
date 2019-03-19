//
//  ViewController.m
//  ZPWKWebView
//
//  Created by 张鹏 on 2017/3/14.
//  Copyright © 2017年 张鹏. All rights reserved.
//

#import "ViewController.h"
#import "ZPWKWebViewController.h"
@interface ViewController ()
@property (nonatomic, assign) BOOL shouldHideHomeIndicator;

@end

@implementation ViewController
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.shouldHideHomeIndicator = YES;
//    if (@available(iOS 11.0, *)) {
//        [self setNeedsUpdateOfHomeIndicatorAutoHidden];
//    } else {
//        // Fallback on earlier versions
//    }
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view, typically from a nib.
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(100, 100, 100, 30)];
    [button setTitle:@"PDFBtn" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(PDFBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
- (void)PDFBtnAction:(UIButton*)button{
    ZPWKWebViewController *zpWebVC = [[ZPWKWebViewController alloc]init];
    zpWebVC.url = @"";
//    zpWebVC.isUseWebTitle = NO;
    
//    zpWebVC.url = @"http://www.baidu.com";
    [self.navigationController pushViewController:zpWebVC animated:YES];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
