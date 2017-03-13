//
//  ForgetPasswordViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/13.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()




@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"找回密码";
    
    [HttpRequest bezierPathToLayerRadiusWithView:_submitButton];
    [HttpRequest bezierPathToLayerRadiusWithView:_getCodeButton];
}


@end
