//
//  FamilySectionView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/9.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "FamilySectionView.h"

@implementation FamilySectionView

+ (instancetype)viewFromXIB {
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    
    return views[0];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    
}


@end
