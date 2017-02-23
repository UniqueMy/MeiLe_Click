//
//  ViewController.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/15.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger , RootViewControllerType) {
    
    RootViewControllerTypeUserGuide, // 用户指引
    RootViewControllerTypeLogin,     // 登录
    RootViewControllerTypeMainView   // 首页
    
};


@interface RootViewController : UIViewController

+ (void)presentViewControllerType:(RootViewControllerType)type;

@end

