//
//  PersonBaseInfoViewController.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/6.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ActionSheetStyle) {
    
    ActionSheet_Photo,
    ActionSheet_Sex,
    
};

@interface PersonBaseInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;

@property (weak, nonatomic) IBOutlet UILabel *sexLabel;

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;



@end
