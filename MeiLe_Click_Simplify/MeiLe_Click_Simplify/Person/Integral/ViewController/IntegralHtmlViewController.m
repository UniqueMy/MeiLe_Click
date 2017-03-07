//
//  IntegralHtmlViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/7.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "IntegralHtmlViewController.h"

#define IntegralHtml @"用户积分"

@interface IntegralHtmlViewController ()

@property(nonatomic,strong) UIWebView *web;

@end

@implementation IntegralHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"说明";
    
    _web = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_web];
    NSString *path = [[NSBundle mainBundle]pathForResource:IntegralHtml ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.web loadHTMLString:htmlString baseURL:nil];
    [self.web sizeToFit];
    self.web.scrollView.bounces = NO;

    
}



@end
