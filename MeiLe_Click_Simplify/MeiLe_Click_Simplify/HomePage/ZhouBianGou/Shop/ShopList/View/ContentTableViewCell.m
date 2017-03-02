//
//  ContentTableViewCell.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/27.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "ContentTableViewCell.h"
#import "ShopListViewController.h"

@implementation ContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (IBAction)reduceButtonClick:(id)sender {
    
    self.shopNumber = [self.amountLabel.text integerValue];
    self.shopNumber --;
    self.amountLabel.text    = [NSString stringWithFormat:@"%ld",(long)self.shopNumber];
    self.amountLabel.hidden  = [self.amountLabel.text integerValue] == 0 ? YES : NO;
    self.reduceButton.hidden = [self.amountLabel.text integerValue] == 0 ? YES : NO;
    
    if ([_delegate respondsToSelector:@selector(changeShopNumber:)]) {
        [_delegate changeShopNumber:NO];
    }
    
}

- (IBAction)addButtonClick:(id)sender {
    
    self.shopNumber = [self.amountLabel.text integerValue];
       self.shopNumber ++;
    self.amountLabel.text    = [NSString stringWithFormat:@"%ld",(long)self.shopNumber];
    self.amountLabel.hidden  = [self.amountLabel.text integerValue] == 0 ? YES : NO;
    self.reduceButton.hidden = [self.amountLabel.text integerValue] == 0 ? YES : NO;
    
    if ([_delegate respondsToSelector:@selector(changeShopNumber:)]) {
        [_delegate changeShopNumber:YES];
    }
   
}



@end
