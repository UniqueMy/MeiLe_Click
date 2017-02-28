//
//  MainViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "MainViewController.h"
#import "NavigationController.h"

#import "HomePageViewController.h"
#import "CustomizationViewController.h"
#import "WareHouseViewController.h"
#import "PersonViewController.h"

@interface MainViewController ()

@property (nonatomic,strong) HomePageViewController      *homePageVC;
@property (nonatomic,strong) CustomizationViewController *customzationVC;
@property (nonatomic,strong) WareHouseViewController     *wareHouseVC;
@property (nonatomic,strong) PersonViewController        *personVC;

@end

@implementation MainViewController

// 懒加载
- (HomePageViewController *)homePageVC {
    
    if (!_homePageVC) {
        
        _homePageVC = [[HomePageViewController alloc] init];
        //        _homePageVC = [[UIStoryboard storyboardWithName:@"THome" bundle:nil] instantiateViewControllerWithIdentifier:@"THomeViewController"];
        UIImage *selectedImage = [[UIImage imageNamed:@"homepage_yes"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *unselectedImage = [UIImage imageNamed:@"homepage_no"];
        _homePageVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:unselectedImage selectedImage:selectedImage];
    }
    return _homePageVC;
}

- (CustomizationViewController *)customzationVC {
    
    if (!_customzationVC) {
        
        _customzationVC = [[CustomizationViewController alloc] init];
        //        _homePageVC = [[UIStoryboard storyboardWithName:@"THome" bundle:nil] instantiateViewControllerWithIdentifier:@"THomeViewController"];
        UIImage *selectedImage = [[UIImage imageNamed:@"customization_yes"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *unselectedImage = [UIImage imageNamed:@"customization_no"];
        _customzationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"定制" image:unselectedImage selectedImage:selectedImage];
    }
    return _customzationVC;
}

- (WareHouseViewController *)wareHouseVC {
    
    if (!_wareHouseVC) {
        
        _wareHouseVC = [[WareHouseViewController alloc] init];
        //        _homePageVC = [[UIStoryboard storyboardWithName:@"THome" bundle:nil] instantiateViewControllerWithIdentifier:@"THomeViewController"];
        UIImage *selectedImage = [[UIImage imageNamed:@"warehouse_yes"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *unselectedImage = [UIImage imageNamed:@"warehouse_no"];
        _wareHouseVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"仓储" image:unselectedImage selectedImage:selectedImage];
    }
    return _wareHouseVC;
}

- (PersonViewController *)personVC {
    
    if (!_personVC) {
        
        _personVC = [[PersonViewController alloc] init];
        //        _homePageVC = [[UIStoryboard storyboardWithName:@"THome" bundle:nil] instantiateViewControllerWithIdentifier:@"THomeViewController"];
        UIImage *selectedImage = [[UIImage imageNamed:@"person_yes"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *unselectedImage = [UIImage imageNamed:@"person_no"];
        _personVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:unselectedImage selectedImage:selectedImage];
    }
    return _personVC;
}

- (void)setNavigationBarStyle:(UINavigationController *)navigationController
{
   navigationController.navigationBar.translucent = NO;
    [navigationController.navigationBar setTintColor:[UIColor blackColor]];
//    [navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    navigationController.navigationBar.shadowImage =[UIImage new];
    navigationController.navigationBar.barTintColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:0.5];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (id)init {
    
    if (self = [super init]) {
        [self setInit];
    }
    
    return self;
}

- (void)setInit {
    
    // 首页
    NavigationController *homePageNavigation = [[NavigationController alloc] initWithRootViewController:self.homePageVC];
    [self setNavigationBarStyle:homePageNavigation];
    
    // 定制
    NavigationController *customzationNavigation = [[NavigationController alloc] initWithRootViewController:self.customzationVC];
    [self setNavigationBarStyle:customzationNavigation];
    
    // 仓储
    NavigationController *wareHouseNavigation = [[NavigationController alloc] initWithRootViewController:self.wareHouseVC];
    [self setNavigationBarStyle:wareHouseNavigation];
    
    // 个人
    NavigationController *personNavigation = [[NavigationController alloc] initWithRootViewController:self.personVC];
    [self setNavigationBarStyle:personNavigation];
    
    [self setViewControllers:@[homePageNavigation,customzationNavigation,wareHouseNavigation,personNavigation]];
    self.tabBar.tintColor = BaseCommonRedColor;
    [self.tabBar setBarTintColor:[UIColor colorWithRed:249/255.90 green:249/255.0 blue:249/255.0 alpha:1.0]];
    
}
@end
