//
//  ViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/15.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "RootViewController.h"
#import "NavigationController.h"

#import "MainViewController.h"
#import "UserGuideViewController.h"
#import "LoginViewController.h"

#import "UserRequestModel.h"


@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self checkFirstLaunch];
}

- (void)checkFirstLaunch {
    
    NSLog(@"----- 检查是否第一次启动软件 ----- ");
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
        NSLog(@"----- 第一次启动 跳转引导页 -----");
        [RootViewController presentViewControllerType:RootViewControllerTypeUserGuide];
        
    } else {
        
        NSLog(@"----- 检查是否需要登录 -----");
        [UserRequestModel checkUserNeedLogin:^(BOOL needLogin) {
            
            if (needLogin) {
                
                NSLog(@"----- 需要登录 -----");
                [RootViewController presentViewControllerType:RootViewControllerTypeLogin];
                
            } else {
                
                NSLog(@"----- 不需要 跳转主界面 -----");
                [RootViewController presentViewControllerType:RootViewControllerTypeMainView];
            }
            
        } failure:^(NSError *error) {
            
            NSLog(@"----- 请求失败 跳转登录界面 -----");
            [RootViewController presentViewControllerType:RootViewControllerTypeLogin];
            
        }];
    }
}

+ (void)presentViewControllerType:(RootViewControllerType)type
{
    UIViewController *viewController = [[[self alloc]init] controllerType:type];
    UIWindow         *mianWindow     = [[UIApplication sharedApplication].delegate window];
    mianWindow.rootViewController    = viewController;
}

// 根据枚举跳转页面
- (UIViewController *)controllerType:(RootViewControllerType)type {
    
    UIViewController *viewController = nil;
    
    switch (type) {
        case RootViewControllerTypeLogin:
        {
            // 登录页
            LoginViewController *login = [[UIStoryboard storyboardWithName:@"Login&Register" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
            viewController = [[NavigationController alloc] initWithRootViewController:login];
        }
            break;
            
        case RootViewControllerTypeMainView:
        {
            // 主页面
            viewController = [[MainViewController alloc] init];
        }
            break;
            
        case RootViewControllerTypeUserGuide:
        {
            // 用户引导页
            viewController = [[UserGuideViewController alloc] init];
            
        }
            break;
            
        default:
            break;
    }
    
    return viewController;
    
}

@end
