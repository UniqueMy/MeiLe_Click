//
//  HomePageViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/20.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "HomePageViewController.h"
#import "UserRequestModel.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
   NSString *loginName = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ADMIN_LOGINNAME_KEY];
    NSLog(@"--- loginName --- %@",loginName);
    NSLog(@" ---  %@",[UserRequestModel getUserLogin].password);
}



@end
