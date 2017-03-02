//
//  ContentTableViewCell.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/27.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContentCellDelegate <NSObject>

- (void)changeShopNumber:(BOOL)isAdd;

@end

@interface ContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *reduceButton;

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (nonatomic,assign) NSInteger shopNumber;

@property (nonatomic,weak) id <ContentCellDelegate> delegate;

@end
