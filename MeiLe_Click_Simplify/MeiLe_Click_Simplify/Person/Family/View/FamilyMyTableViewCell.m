//
//  FamilyMyTableViewCell.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/9.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "FamilyMyTableViewCell.h"

@interface FamilyMyTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;


@end

@implementation FamilyMyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _headImageView.layer.cornerRadius  = _headImageView.bounds.size.width / 2;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.borderColor   = [UIColor grayColor].CGColor;
    _headImageView.layer.borderWidth   = .5;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
