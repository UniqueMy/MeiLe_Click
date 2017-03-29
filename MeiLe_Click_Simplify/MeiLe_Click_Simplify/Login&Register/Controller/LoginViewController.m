//
//  LoginViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "LoginViewController.h"
#import "UserRequestModel.h"
#import "RootViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *inputAreaView;

@end

@implementation LoginViewController
{
    CGFloat _keyboardhight ;
    CGFloat _offset;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    [self registerForKeyboardNotifications];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _weixinButton.layer.cornerRadius  = Radius;
    _weixinButton.layer.masksToBounds = YES;
    _weixinButton.layer.borderColor   = RGB(70, 70, 70).CGColor;
    _weixinButton.layer.borderWidth   = 1.f;
    

    _userNameTextField.leftView     = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 5, 30)];
    _userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.leftView     = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 5, 30)];
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [HttpRequest bezierPathToLayerRadiusWithView:_submitButton];
    
    // 登录事件
    _passwordTextField.returnKeyType = UIReturnKeyNext;
    _passwordTextField.delegate      = self;
    
    // 从本地读取数据自动填充
    NSString *loginName = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ADMIN_LOGINNAME_KEY];
    NSLog(@"--- 本地获取账号 --- %@",loginName);
    
    if ([loginName isKindOfClass:[NSString class]] && loginName.length != 0) {
        
        _userNameTextField.text = loginName;
    }
    
    // 接受通知获取账号、密码
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputloginNameAndPassword:) name:@"InputloginNameAndPassword" object:nil];

}

#pragma mark -- 接受通知获取账号、密码
- (void)inputloginNameAndPassword:(NSNotification *)info
{
    NSString    *mobilePhone = [info.userInfo objectForKey:@"loginName"];
    NSString    *password    = [info.userInfo objectForKey:@"password"];
    _userNameTextField.text  = mobilePhone;
    _passwordTextField.text  = password;
}

#pragma mark - 提交登录事件
- (IBAction)onLoginSubmitAction:(id)sender {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:RGBA(0, 0, 0, 0.6)];
    
    if (_userNameTextField.text.length == 0) {

        [SVProgressHUD showImage:nil status:@"手机号不能为空"];
        return;
    }
    
    if (_passwordTextField.text.length == 0) {
       
        [SVProgressHUD showImage:nil status:@"密码不能为空"];
        return;
    }
    
    NSDictionary *parameters = @{@"loginName":_userNameTextField.text,
                                 @"password":_passwordTextField.text};

    
    [UserRequestModel requestLoginWithDictionary:parameters success:^(NSString *path, NSDictionary *responseJson, id responseBody, NSInteger code) {
        
        NSLog(@"----- 登录成功 跳转主界面 -----");
        [RootViewController presentViewControllerType:RootViewControllerTypeMainView];
        
    } failure:^(NSString *path, NSError *error) {
        
    }];
}

#pragma mark -- 键盘升降
- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    
    CGRect kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];//得到鍵盤的高度
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    _offset = CGRectGetMaxY(_inputAreaView.frame)- CGRectGetMaxY(_inputAreaView.frame)+50;
    if (kbSize.origin.y< CGRectGetMaxY(_inputAreaView.frame)) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -_offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
    double duration = [[aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_passwordTextField isFirstResponder]) {
        [_passwordTextField resignFirstResponder];
    }
    
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_passwordTextField resignFirstResponder];
    [_userNameTextField resignFirstResponder];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"InputloginNameAndPassword" object:nil];
}


@end
