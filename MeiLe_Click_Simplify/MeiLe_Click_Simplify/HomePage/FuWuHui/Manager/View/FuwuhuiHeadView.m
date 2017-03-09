//
//  FuwuhuiHeadView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/28.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "FuwuhuiHeadView.h"

@implementation FuwuhuiHeadView
{
    UIView  *kindView;
    UILabel *titleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        kindView = [[UIView alloc] initWithFrame:CGRectMake(13, 12, 2, 13)];
        
        [self addSubview:kindView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(kindView.frame) + 6,
                                                               10,
                                                               60,
                                                               17)];
        titleLabel.textColor = RGB(28, 28, 28);
        titleLabel.font      = [UIFont systemFontOfSize:12];
       
        [self addSubview:titleLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    kindView.backgroundColor = _kindColor;
    titleLabel.text      = _title;
}

@end
