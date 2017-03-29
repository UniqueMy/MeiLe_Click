//
//  SHDatePickerView.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/21.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SHDatePickerViewDelegate <NSObject>

- (void)submitDate:(NSString *)dateString;
- (void)removeDatePicker;
@end

@interface SHDatePickerView : UIView

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (nonatomic,weak) id <SHDatePickerViewDelegate> delegate;

+ (instancetype)viewFromXIB;

@end
