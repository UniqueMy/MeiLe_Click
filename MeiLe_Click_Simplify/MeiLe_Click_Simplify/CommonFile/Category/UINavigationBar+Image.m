//
//  UINavigationBar+Image.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/7.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "UINavigationBar+Image.h"

@implementation UINavigationBar (Image)

// 设置导航条背景图片 navigation_bar_bg.png
- (void)setCustomNavigationBarWithImage:(UIImage *)image
{
    
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
    }
    
   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
}

- (void)setResultNavigationBar {
    
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(70, 70, 70),NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    
}
@end
