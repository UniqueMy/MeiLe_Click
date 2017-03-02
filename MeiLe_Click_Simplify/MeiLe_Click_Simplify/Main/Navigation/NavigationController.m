//
//  NavigationController.m
//  MeiLe_Click
//
//  Created by 盛浩 on 2017/2/6.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigationController

-(void)viewDidLoad
{
    [super viewDidLoad];
    __weak NavigationController * weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(71, 71, 71),NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}




@end
