//
//  LifeCircleTableSectionView.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/14.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LifeCircleTableSectionView : UIView

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UIButton *locationButton;

+ (instancetype)viewFromXIB;

@end
