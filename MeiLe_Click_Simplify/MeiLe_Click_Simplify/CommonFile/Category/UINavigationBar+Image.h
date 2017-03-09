//
//  UINavigationBar+Image.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/7.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Image)

// 设置导航条背景图片
- (void)setCustomNavigationBarWithImage:(UIImage *)image;

// 还原导航条默认背景
- (void)setResultNavigationBar;

@end
