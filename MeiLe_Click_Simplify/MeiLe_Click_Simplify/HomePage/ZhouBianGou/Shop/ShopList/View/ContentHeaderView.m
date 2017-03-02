//
//  ContentHeaderView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/1.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "ContentHeaderView.h"

@implementation ContentHeaderView
{
    UILabel *businessLabel;
    UILabel *moneyLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        businessLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 10, 186, 17)];
        businessLabel.font = [UIFont systemFontOfSize:12];
        businessLabel.textColor = RGB(71, 71, 71);
        [self addSubview:businessLabel];
        
        moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(businessLabel.frame), 10, 60, 17)];
        moneyLabel.font = [UIFont systemFontOfSize:12];
        moneyLabel.textColor = RGB(71, 71, 71);
        [self addSubview:moneyLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 36, self.bounds.size.width, 1)];
        
        [self addSubview:line];
        
        [HttpRequest drawDashLine:line lineLength:5 lineSpacing:5 lineColor:RGB(222, 222, 223)];
        
    }
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    businessLabel.text = self.business;
    moneyLabel.text    = self.money;
}

@end
