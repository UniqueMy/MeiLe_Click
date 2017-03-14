//
//  LifecircleCollectionHeaderView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/14.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "LifecircleCollectionHeaderView.h"

@implementation LifecircleCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGB(244, 244, 244);
        
        UILabel *title  = [[UILabel alloc] init];
        title.frame     = CGRectMake(8, 9, 100, 20);
        title.font      = [UIFont systemFontOfSize:14];
        title.text      = @"已开通城市";
        title.textColor = RGB(70, 70, 70);
        [self addSubview:title];
    }
    return self;
}

@end
