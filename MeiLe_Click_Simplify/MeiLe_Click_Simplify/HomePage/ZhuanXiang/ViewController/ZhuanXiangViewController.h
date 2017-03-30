//
//  ZhuanXiangViewController.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/30.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ZhuangXiangType) {
    
    ZhuangXiangType_JingDong,
    ZhuangXiangType_TaoBao,
    
};


@interface ZhuanXiangViewController : UIViewController

@property (nonatomic,strong) NSString        *titleString;
@property (nonatomic,assign) ZhuangXiangType  type;

@end
