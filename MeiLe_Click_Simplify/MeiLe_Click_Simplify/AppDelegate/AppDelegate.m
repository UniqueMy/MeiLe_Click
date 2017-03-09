//
//  AppDelegate.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/15.
//  Copyright © 2017年 ShengHao. All rights reserved.
//
/*               3月
 借呗   10000     914
 微信   15000     0
 百度   28500    3153 + 943
 招联   9500      880
 信用   20000    3013
 京东   3700      0
 
 
总计：            8903
 
 
 */

#import "AppDelegate.h"
#import "RootViewController.h"
#import "NSArray+RemoveNull.h"
#import "NSDictionary+RemoveNull.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
{
    BMKMapManager* _mapManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"---- 开始初始化六项 -----");
    [[HttpRequest sharedInstance] userInit];
    
    // 设置根视图
    [self makeWindowVisible:launchOptions];
    
    // 初始化第三方库
    [self basicSetup];
    
    return YES;
}

#pragma mark - 初始化第三方库
- (void)basicSetup {
    
    // 百度地图初始化
    _mapManager           = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:BaiduMap_Appkey generalDelegate:nil];
    if (!ret) {
        NSLog(@"百度地图初始化失败！");
    }
    
}

#pragma mark - Make window visible
- (void)makeWindowVisible:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.window         = [[UIWindow alloc] initWithFrame:screenBounds];
    self.window.backgroundColor    = [UIColor whiteColor];
    self.window.rootViewController = [[RootViewController alloc] init];
    [self.window makeKeyAndVisible];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    /*  XingYongKa
     *
     *
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
