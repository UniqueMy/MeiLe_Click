//
//  LifecircleCollectionViewCell.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/14.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "LifecircleCollectionViewCell.h"

@implementation LifecircleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

-(void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    self.backgroundImage.image = selected ? [UIImage imageNamed:@"common_lifecircle_yes"]:[UIImage imageNamed:@"common_lifecircle_no"];
    self.cityName.textColor = selected ? RGB(180, 40, 45) : RGB(180, 180, 180);
}

@end
