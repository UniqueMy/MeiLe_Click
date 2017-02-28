//
//  titleTableViewCell.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/27.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "TitleTableViewCell.h"

@implementation TitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = RGB(248, 248, 248);
     self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.showView.hidden = !selected;
    self.titleLabel.font = selected ? [UIFont systemFontOfSize:13] : [UIFont systemFontOfSize:12];
    self.titleLabel.textColor = selected ? BaseCommonRedColor : RGB(70, 70, 70);
}

@end
