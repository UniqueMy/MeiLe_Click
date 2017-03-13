//
//  RegisterProtorlViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/13.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "RegisterProtorlViewController.h"

@interface RegisterProtorlViewController ()

#define IntegralHtml @"美乐生活用户注册协议"

@property(nonatomic,strong) UIWebView *web;

@end

@implementation RegisterProtorlViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户注册协议";
    
    _web = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_web];
    NSString *path = [[NSBundle mainBundle]pathForResource:IntegralHtml ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.web loadHTMLString:htmlString baseURL:nil];
    [self.web sizeToFit];
    self.web.scrollView.bounces = NO;
    
    
}


@end
