//
//  TitleCollectionViewCell.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/21.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "TitleCollectionViewCell.h"

@implementation TitleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel       = [[UILabel alloc] init];
        self.titleLabel.frame = self.bounds;
        self.titleLabel.textAlignment = 1;
        self.titleLabel.textColor = RGB(71, 71, 71);
        self.titleLabel.font      = [UIFont systemFontOfSize:14];
        [self addSubview:self.titleLabel];
//        
//        self.moveView       = [[UIView alloc] init];
//        self.moveView.frame = CGRectMake((self.bounds.size.width - 59) / 2, self.bounds.size.height - 2, 59, 2);
//        self.moveView.backgroundColor = RGB(180, 40, 45);
//        [self addSubview:self.moveView];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    self.titleLabel.textColor = selected ? RGB(180, 40, 45) : RGB(71, 71, 71);
//    self.moveView.backgroundColor       = selected ? RGB(180, 40, 45) : RGB(249, 249, 249);
}

@end
