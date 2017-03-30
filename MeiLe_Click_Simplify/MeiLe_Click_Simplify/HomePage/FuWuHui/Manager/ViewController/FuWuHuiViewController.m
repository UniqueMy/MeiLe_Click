//
//  FuWuHuiViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/22.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "FuWuHuiViewController.h"
#import "FuwuhuiHeadView.h"
#import "FuwuhuiFootView.h"
#import "FuwuhuiCollectionViewCell.h"
#import "WuYeJiaoFeiViewController.h"
#import "JingDongViewController.h"
#import "JingDongDetailViewController.h"

#import "ZhuanXiangViewController.h"

static NSString *identifier = @"FuwuhuiCollectionViewCell";

@interface FuWuHuiViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView           *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;


@end

@implementation FuWuHuiViewController


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect collectFrame = CGRectMake(0, 0, viewWidth, self.view.bounds.size.height - Navigation_Height);
    _collectionView.frame  = collectFrame;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 102
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(viewWidth / 4, 88);
    _flowLayout.minimumLineSpacing      = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.headerReferenceSize     = CGSizeMake(viewWidth, 37);
    _flowLayout.footerReferenceSize     = CGSizeMake(viewWidth, 7);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FuwuhuiCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    [_collectionView registerClass:[FuwuhuiHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [_collectionView registerClass:[FuwuhuiFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FootView"];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 5;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        FuwuhuiHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.kindColor = @[RGB(121, 169, 234),RGB(244, 143, 25),RGB(255, 132, 98)][indexPath.section];
        headerView.title = @[@"物业服务",@"城市服务",@"常用电商"][indexPath.section];
        return headerView;
        
    } else {
        
        FuwuhuiFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FootView" forIndexPath:indexPath];
        return footView;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FuwuhuiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.nameLabel.text = @"物业缴费";
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.nameLabel.text = @"京东专享";
        cell.iconImage.image = [UIImage imageNamed:@"jingdongLogo"];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        cell.nameLabel.text = @"淘宝专享";
        cell.iconImage.image = [UIImage imageNamed:@"taobaoLogo"];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexPath %ld",(long)indexPath.row);
    if (indexPath.section == 0 && indexPath.row == 0) {
        // 物业缴费
        WuYeJiaoFeiViewController *wyjfVC = [[WuYeJiaoFeiViewController alloc] init];
        [self.navigationController pushViewController:wyjfVC animated:YES];
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        ZhuanXiangViewController *zhuanxiangVC = [[ZhuanXiangViewController alloc] init];
        zhuanxiangVC.titleString = @"京东专享";
        zhuanxiangVC.type = ZhuangXiangType_JingDong;
        [self.navigationController pushViewController:zhuanxiangVC animated:YES];
        
        // 京东授权 、 京东专享
        // 判断是否有access_token
        //        NSString *tokenString = [[NSUserDefaults standardUserDefaults] objectForKey:JingDong_Access_token];
        //        if (![tokenString isKindOfClass:[NSNull class]] && tokenString.length != 0) {
        //
        //             NSLog(@"token存在 %@  跳转推广页",tokenString);
        //            JingDongDetailViewController *jingdongVC = [[JingDongDetailViewController alloc] init];
        //            [self.navigationController pushViewController:jingdongVC animated:YES];
        //
        //        } else {
        //
        //             NSLog(@"token不存在 %@  跳转授权页",tokenString);
        //            JingDongViewController *jingdongVC = [[JingDongViewController alloc] init];
        //            [self.navigationController pushViewController:jingdongVC animated:YES];
        //            
        //        }
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        ZhuanXiangViewController *zhuanxiangVC = [[ZhuanXiangViewController alloc] init];
        zhuanxiangVC.titleString = @"淘宝专享";
        zhuanxiangVC.type = ZhuangXiangType_TaoBao;
        [self.navigationController pushViewController:zhuanxiangVC animated:YES];
        
        }

    
    
    
}

@end
