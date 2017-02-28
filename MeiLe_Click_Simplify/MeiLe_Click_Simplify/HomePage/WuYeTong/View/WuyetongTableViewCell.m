//
//  WuyetongTableViewCell.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/28.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "WuyetongTableViewCell.h"

@implementation WuyetongTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.wuyeHeadImage.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.wuyeHeadImage.bounds.size.width / 2, self.wuyeHeadImage.bounds.size.width / 2)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame         = self.wuyeHeadImage.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.wuyeHeadImage.layer.mask   = maskLayer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
