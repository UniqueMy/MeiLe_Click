//
//  PersonSignatureViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/21.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "PersonSignatureViewController.h"

@interface PersonSignatureViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *textnumberLabel;

@end

@implementation PersonSignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"签名";
    
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitleColor:RGB(208, 101, 86) forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;

    _textView.text     = _signatureString;
    _textView.delegate = self;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if(_textView.text.length <= 50) {
        
        _textnumberLabel.text = [NSString stringWithFormat:@"还剩%lu个字可以输入",50 - _textView.text.length];
        
    }
    //该判断用于联想输入
    if (textView.text.length > 50) {
        
        textView.text = [textView.text substringToIndex:50];
    }
}

//限制输入字数
- (void)textViewDidChange:(UITextView *)textView{
    
    if(_textView.text.length <= 50) {
       
        _textnumberLabel.text = [NSString stringWithFormat:@"还剩%lu个字可以输入",50 - _textView.text.length];
        
    }
    //该判断用于联想输入
    if (textView.text.length > 50) {
        
        textView.text = [textView.text substringToIndex:50];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    _textnumberLabel.text = @"";
}

- (void)save {
    
    if ([_delegate respondsToSelector:@selector(saveSignatureWithString:)]) {
        [_delegate saveSignatureWithString:_textView.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_textView resignFirstResponder];
}

@end
