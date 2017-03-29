//
//  JingDongViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/27.
//  Copyright © 2017年 ShengHao. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "JingDongViewController.h"
#import "JingDongDetailViewController.h"

#define JingDong_Key @"847CB249F0D19F46B1EE254EF665956D"

@interface JingDongViewController ()<WKNavigationDelegate>

@end

@implementation JingDongViewController
{
    NSString *popularizeUrl;
    NSString *testUrl;
    WKWebView *SHWebView;
    NSString *codeString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"京东授权";
    
   // 1c5f282f-a760-437f-8941-639cd3eb5f4d 美创互联 token
   // 11b8eef1-7d50-4eac-81fa-b6284ac393a7 my
   // 847CB249F0D19F46B1EE254EF665956D     key
   // ae7cdcc09843415d85dc2bd63ac4077f     secret
   // 1000174701                           id
    
    /*
     点击京东 美创互联
     
     判断是否有token
     1.有    进入推广页
     2.没有  进入授权页  授权成功 后跳转推广页
     
     推广页中
     
     token过期 跳转授权页
     
     【问题】
     1.授权页登录后  推广页还是需要登录
     2.推广页登录后一月内 免登陆  此期间 更换APP用户  是否会
     
     退出APP时更改token 避免京东账号泄露
     
     */
    
    SHWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight - Navigation_Height)];
    SHWebView.navigationDelegate = self;
    [self.view addSubview:SHWebView];
    
    NSString *url = [NSString stringWithFormat:@"https://oauth.jd.com/oauth/authorize?response_type=code&client_id=847CB249F0D19F46B1EE254EF665956D&redirect_uri=%@&view=wap",JingDong_HuiDiaoAddress];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [SHWebView loadRequest:request];
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    
    urlString           = [urlString stringByRemovingPercentEncoding];
  
    NSLog(@"--授权--- urlString ----- %@",urlString);
    
    if ( [[urlString substringWithRange:NSMakeRange(7, 8)] isEqualToString:@"devonios"] ) {
        
        NSArray *array = [urlString componentsSeparatedByString:@"="];
        
        if (array.count > 1) {
            codeString = [array lastObject];
        }
        
        NSString *url = [NSString stringWithFormat:@"https://oauth.jd.com/oauth/token?grant_type=authorization_code&client_id=847CB249F0D19F46B1EE254EF665956D&redirect_uri=%@&code=%@&client_secret=ae7cdcc09843415d85dc2bd63ac4077f",JingDong_HuiDiaoAddress,codeString];
        
         NSLog(@"url %@",url);
        
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        
        
        [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
          
            NSLog(@"--授权--成功-- %@",responseObject);
            
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"access_token"] forKey:JingDong_Access_token];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            decisionHandler(WKNavigationActionPolicyCancel);
           
            [SHWebView removeFromSuperview];
            
            [self.navigationController pushViewController:[JingDongDetailViewController new] animated:YES];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"失败 %@",error);
            
            
           decisionHandler(WKNavigationActionPolicyCancel);
        }];
        
    } else {
        
         decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}


@end
