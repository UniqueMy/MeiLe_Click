//
//  ZhouBianGouViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/22.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "ZhouBianGouViewController.h"
#import "SHRollScrollView.h"


#define SCROLLVIEW_HEIGHT 148

@interface ZhouBianGouViewController ()<UIScrollViewDelegate>

@end

@implementation ZhouBianGouViewController
{
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
       
    SHRollScrollView *scrollView = [[SHRollScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, SCROLLVIEW_HEIGHT)];
//    scrollView.frame      = ;
    scrollView.imageArray = @[@"homepage_zbg_scroll_0",@"homepage_zbg_scroll_0"];
    [self.view addSubview:scrollView];
    
    
//    XMGInfiniteScrollView *scrollView = [[XMGInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, SCROLLVIEW_HEIGHT)];
//    //    scrollView.frame      = ;
//    scrollView.imageNames = @[@"homepage_zbg_scroll_0",@"homepage_zbg_scroll_0"];
//    [self.view addSubview:scrollView];
    
}


@end
