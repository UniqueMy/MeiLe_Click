//
//  SHDatePickerView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/21.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "SHDatePickerView.h"

@implementation SHDatePickerView
{
    NSString *dateString;
}

+ (instancetype)viewFromXIB {
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    
    return views[0];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.maximumDate     = [NSDate date];
    [_datePicker addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    dateString = [formatter stringFromDate:_datePicker.date];
    
}

- (void)change:(id)sender {
    
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* date          = control.date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    dateString = [formatter stringFromDate:date];
    
}

- (IBAction)cancel:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(removeDatePicker)]) {
        [_delegate removeDatePicker];
    }
    
}

- (IBAction)submit:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(submitDate:)]) {
        [_delegate submitDate:dateString];
    }
    
}

@end
