//
//  JingDongDetailViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/29.
//  Copyright © 2017年 ShengHao. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "JingDongDetailViewController.h"
#import "FuWuHuiViewController.h"
#import "HomePageViewController.h"

@interface JingDongDetailViewController ()<WKNavigationDelegate>

@end

@implementation JingDongDetailViewController
{
     WKWebView *SHWebView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title = @"京东专享";
    
    
    [self addLeftBarItem];
    
    
    SHWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight - Navigation_Height)];
    SHWebView.navigationDelegate = self;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:JingDong_PopularizeUrl]];
    [SHWebView loadRequest:request];
    [self.view addSubview:SHWebView];
  //  美创互联
}

- (void)addLeftBarItem {
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"common_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backItemClick)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
}

- (void)backItemClick {
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        if ([controller isKindOfClass:[HomePageViewController class]]) {
            
            HomePageViewController *revise =(HomePageViewController *)controller;
            
            [self.navigationController popToViewController:revise animated:YES];
            
        }
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    
    urlString           = [urlString stringByRemovingPercentEncoding];
    
    NSLog(@"---京东专享 ---- urlString ----- %@",urlString);
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
  
    
}


@end
