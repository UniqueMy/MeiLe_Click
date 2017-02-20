//
//  RegisterViewController.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/20.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *getVerCodeButton;

@property (weak, nonatomic) IBOutlet UIButton *registSubmitButton;

@property (weak, nonatomic) IBOutlet UITextField *registMobileTextField;

@property (weak, nonatomic) IBOutlet UITextField *registCaptchasTextField;

@property (weak, nonatomic) IBOutlet UITextField *registPasswordTextField;

@property (weak, nonatomic) IBOutlet UIButton *agreeButton;

@property (weak, nonatomic) IBOutlet UIButton *zhongMeiProtocol;

@end
