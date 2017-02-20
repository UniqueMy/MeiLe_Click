//
//  RegisterViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/20.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "RegisterViewController.h"

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
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.backIndicatorImage = [[UIImage alloc]init];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self registerForKeyboardNotifications];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUitextFile:_registMobileTextField];
    [self setUitextFile:_registCaptchasTextField];
    [self setUitextFile:_registPasswordTextField];
    
    _agreeButton.selected = YES;
    [_agreeButton addTarget:self action:@selector(stateChange:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)stateChange:(UIButton *)button
{
    button.selected = !button.selected;
}


// 设置textField样式
- (void)setUitextFile:(UITextField*)textFile
{
    [textFile setBackground:[[UIImage imageNamed:@"login_textField"]resizableImageWithCapInsets:UIEdgeInsetsMake(8, 20, 8, 20) resizingMode:UIImageResizingModeTile]];
    textFile.leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 30)];
    textFile.leftViewMode = UITextFieldViewModeAlways;
    
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
    
    if (kbSize.origin.y<CGRectGetMaxY(_inputAreaView.frame)) {
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
