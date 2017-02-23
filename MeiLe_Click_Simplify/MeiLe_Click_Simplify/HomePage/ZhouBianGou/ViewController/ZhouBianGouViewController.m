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
       
    SHRollScrollView *rollScrollView = [[SHRollScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, SCROLLVIEW_HEIGHT) viewController:self];
    [self.view addSubview:rollScrollView];
    [rollScrollView addPageControl];
    
}


@end
