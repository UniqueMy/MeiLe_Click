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

        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    self.titleLabel.textColor = selected ? BaseCommonRedColor : RGB(71, 71, 71);

}

@end
