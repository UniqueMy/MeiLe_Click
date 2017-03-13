//
//  RegisterViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/20.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterProtorlViewController.h"
#import "NSString+Zhengze.h"
#import "UserRequestModel.h"
#import "ReferenceViewController.h"
#import "RootViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UIView *inputAreaView;

@property (weak, nonatomic) IBOutlet UIButton *bandAcount;

@end

@implementation RegisterViewController
{
    CGFloat _keyboardhight;
    CGFloat _offset;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    
    _agreeButton.selected = YES;
    [_agreeButton addTarget:self action:@selector(stateChange:) forControlEvents:UIControlEventTouchUpInside];
    [HttpRequest bezierPathToLayerRadiusWithView:_getVerCodeButton];
    [HttpRequest bezierPathToLayerRadiusWithView:_registSubmitButton];
}

- (void)stateChange:(UIButton *)button
{
    button.selected = !button.selected;
}

- (IBAction)registerProtocol:(id)sender {
    
    [self.navigationController pushViewController:[RegisterProtorlViewController new] animated:YES];
    
}

- (IBAction)getCodeButton:(id)sender {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:RGBA(0, 0, 0, 0.6)];
    
    if (![_registMobileTextField.text isPhoneNumberString:_registMobileTextField.text]) {
        
        [SVProgressHUD showImage:nil status:@"请输入正确的手机号码"];
        return;
    }
    
    if (_registMobileTextField.text.length == 0) {
        
        [SVProgressHUD showImage:nil status:@"手机号不能为空"];
        return;
    }
    
    [UserRequestModel sendCaptcha:_registMobileTextField.text completed:^(BOOL isSuccess) {
        
        if (isSuccess) {
            
            [_registCaptchasTextField becomeFirstResponder];
            [self performSelector:@selector(reflashGetKeyBt:) withObject:[NSNumber numberWithInt:60] afterDelay:0];
        }
        
    }];
}

- (void)reflashGetKeyBt:(NSNumber *)second
{
    if ([second integerValue] == 0) {
        [_getVerCodeButton setEnabled:YES];
        [_getVerCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    } else {
        [_getVerCodeButton setEnabled:NO];
        int i = [second intValue];
        [_getVerCodeButton setTitle:[NSString stringWithFormat:@"剩余%d秒", i] forState:UIControlStateNormal];
        [self performSelector:@selector(reflashGetKeyBt:) withObject:[NSNumber numberWithInt:i - 1] afterDelay:1];
    }
}


- (IBAction)submitRegister:(id)sender {
    
//    ReferenceViewController *referenceVC = [[ReferenceViewController alloc] init];
//     [self presentViewController:referenceVC animated:YES completion:nil];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:RGBA(0, 0, 0, 0.6)];
    
    if (!_agreeButton.isSelected) {
        
        [SVProgressHUD showImage:nil status:@"请同意《中美社区用户注册协议》"];
        return;
    }
    
    if (_registMobileTextField.text.length == 0) {
        
        [SVProgressHUD showImage:nil status:@"手机号不能为空"];
        return;
    }
    
    if (![_registMobileTextField.text isPhoneNumberString:_registMobileTextField.text]) {
        
        [SVProgressHUD showImage:nil status:@"请输入正确的手机号码"];
        return;
    }
    
    if (_registPasswordTextField.text.length == 0) {
        
        [SVProgressHUD showImage:nil status:@"密码不能为空"];
        return;
    }
    
    if (![NSString checkPassWordAndLenth:_registPasswordTextField.text]) {
        
        [SVProgressHUD showImage:nil status:@"密码为6～20位的字母或数字"];
        return;
    }
    
    if (_registCaptchasTextField.text.length == 0) {
        
        [SVProgressHUD showImage:nil status:@"验证码不能为空"];
        return;
    }
    
    NSString *mobilePhone = _registMobileTextField.text;
    NSString *password    = _registPasswordTextField.text;
    NSString *captchas    = _registCaptchasTextField.text;
    
    NSDictionary *parameters = @{@"mobilePhone":mobilePhone,
                                 @"password":[HttpRequest secureHashAlgorithmWithNSString:password],
                                 @"captchas":captchas};
    [[HttpRequest sharedInstance] baseRequestNeedTicketCommonWithUrl:@"/tenement-service/user/user.toRegist.json" body_data:parameters success:^(NSString *path, NSDictionary *responseJson, NSDictionary *responseBody, NSInteger code) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"InputloginNameAndPassword" object:nil userInfo:@{@"mobilePhone":mobilePhone, @"password":password}];
        
        _registMobileTextField.text   = @"";
        _registPasswordTextField.text = @"";
        _registCaptchasTextField.text = @"";
        
        NSDictionary *parameters = @{@"loginName":mobilePhone,
                                     @"password" :password};
        
        [UserRequestModel requestLoginWithDictionary:parameters success:^(NSString *path, NSDictionary *responseJson, NSDictionary *responseBody, NSInteger code) {
            
            ReferenceViewController *referenceVC = [[ReferenceViewController alloc] init];
            [self presentViewController:referenceVC animated:YES completion:nil];
            
        } failure:^(NSString *path, NSError *error) {
            
            [RootViewController presentViewControllerType:RootViewControllerTypeLogin];
            
        }];
        
    } fail:^(NSString *path, NSError *error) {
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_registPasswordTextField isFirstResponder]) {
        [_registCaptchasTextField becomeFirstResponder];
    }
    
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_registCaptchasTextField resignFirstResponder];
    [_registMobileTextField resignFirstResponder];
    [_registPasswordTextField resignFirstResponder];
}

- (void)registerForKeyboardNotifications
{
    // 使用NSNotificationCenter 出現時
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)name:UIKeyboardWillShowNotification object:nil];
    // 使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

// 实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    // kbSize即為鍵盤尺寸 (有width, height)
    CGRect kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];// 得到鍵盤的高度
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    _offset = CGRectGetMaxY(_inputAreaView.frame) - kbSize.origin.y;
    
    if (kbSize.origin.y < CGRectGetMaxY(_inputAreaView.frame)) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -_offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}
// 当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    // do something
    double duration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



@end
