//
//  ZhuanXiangViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/30.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "ZhuanXiangViewController.h"
#import <WebKit/WebKit.h>
#import "HomePageViewController.h"

@interface ZhuanXiangViewController ()<WKNavigationDelegate>

@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation ZhuanXiangViewController

{
    WKWebView *SHWebView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = _titleString;
    
    
    [self addLeftBarItem];
    
    
    SHWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight - Navigation_Height)];
    SHWebView.navigationDelegate = self;
     [self.view addSubview:SHWebView];
    
    NSString *url = nil;
    
    switch (_type) {
        case ZhuangXiangType_JingDong:
        {
            url = JingDong_PopularizeUrl;
        }
            break;
        case ZhuangXiangType_TaoBao:
        {
            url = TaoBao_PopularizeUrl;
        }
            break;
            
        default:
            break;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSLog(@"_urlString %@",url);
    [SHWebView loadRequest:request];
    
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),.7f)];
    [self.view addSubview:_progressView];
    
    [SHWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
   
    if ([keyPath isEqual: @"estimatedProgress"] && object == SHWebView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:SHWebView.estimatedProgress animated:YES];
        if(SHWebView.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
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
    
    NSLog(@"---%@ ---- urlString ----- %@",_titleString,urlString);
    
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (void)dealloc {
    
    [SHWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [SHWebView setNavigationDelegate:nil];
   
}



@end
