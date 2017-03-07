//
//  IntegralTopView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/7.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "IntegralTopView.h"

@implementation IntegralTopView

+ (instancetype)viewFromXIB {
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    
    return views[0];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];

    
}


@end
