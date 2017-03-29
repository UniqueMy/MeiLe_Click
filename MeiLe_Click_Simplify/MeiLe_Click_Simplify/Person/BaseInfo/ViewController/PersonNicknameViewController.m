//
//  PersonNicknameViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/20.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "PersonNicknameViewController.h"

@interface PersonNicknameViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation PersonNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"昵称";
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitleColor:RGB(208, 101, 86) forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
  
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    _textField.leftView     = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.text         = _textString;
    
}

- (void)save {
    
    if ([_delegate respondsToSelector:@selector(saveNicknameWithString:)]) {
        [_delegate saveNicknameWithString:_textField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_textField resignFirstResponder];
}
@end
