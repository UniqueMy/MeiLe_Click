//
//  ChangeTitleView.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/21.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeTitleViewDelegate <NSObject>

- (void)didClickTitleIndex:(NSInteger)index;

@end

@interface ChangeTitleView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) id<ChangeTitleViewDelegate> delegate;

- (void)selectedTitle:(NSInteger)number;

@end
