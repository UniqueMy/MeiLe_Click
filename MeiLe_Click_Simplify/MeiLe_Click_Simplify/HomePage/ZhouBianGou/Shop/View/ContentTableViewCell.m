//
//  ContentTableViewCell.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/27.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "ContentTableViewCell.h"

@implementation ContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
