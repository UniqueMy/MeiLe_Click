//
//  CustomizationViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/20.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "CustomizationViewController.h"
#import "SHRollScrollView.h"

#define kWidthOfScreen  [[UIScreen mainScreen] bounds].size.width
#define kHeightOfScreen [[UIScreen mainScreen] bounds].size.height

@interface CustomizationViewController ()<UIScrollViewDelegate>




@end

@implementation CustomizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    SHRollScrollView *rollScrollView = [[SHRollScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 152)];
    [self.view addSubview:rollScrollView];
}


@end
