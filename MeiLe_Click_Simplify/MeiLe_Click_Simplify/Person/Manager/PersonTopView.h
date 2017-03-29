//
//  PersonTopView.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/6.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonTopViewDelegate <NSObject>

- (void)pushMessageView;

@end

@interface PersonTopView : UIView

+ (instancetype)viewFromXIB;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UIButton *messageButton;

@property (nonatomic,weak) id <PersonTopViewDelegate> delegate;

@end
