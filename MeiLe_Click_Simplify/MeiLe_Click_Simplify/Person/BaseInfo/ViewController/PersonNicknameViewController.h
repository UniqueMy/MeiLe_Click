//
//  PersonNicknameViewController.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/20.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonNicknameDelegate <NSObject>

- (void)saveNicknameWithString:(NSString *)string;

@end

@interface PersonNicknameViewController : UIViewController

@property (nonatomic,weak) id <PersonNicknameDelegate> delegate;



@property (nonatomic,strong) NSString *textString;

@end
