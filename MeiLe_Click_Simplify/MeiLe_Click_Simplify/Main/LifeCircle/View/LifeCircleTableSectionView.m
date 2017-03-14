//
//  LifeCircleTableSectionView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/14.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "LifeCircleTableSectionView.h"

@implementation LifeCircleTableSectionView

+ (instancetype)viewFromXIB {
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    
    return views[0];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    
}

- (IBAction)startLocation:(id)sender {
    
    
}

@end
