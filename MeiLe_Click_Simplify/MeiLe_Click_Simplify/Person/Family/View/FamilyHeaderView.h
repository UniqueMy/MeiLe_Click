//
//  FamilyHeaderView.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/7.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FamilyHeaderViewDelegate <NSObject>

- (void)reloadTableViewCellIsMe:(BOOL)isMe;

@end

@interface FamilyHeaderView : UIView

+ (instancetype)viewFromXIB;

@property (nonatomic,weak) id <FamilyHeaderViewDelegate> delegate;

@end
