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
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexPath %ld",(long)indexPath.row);
    if (indexPath.row == 1) {
        // 物业缴费
        WuYeJiaoFeiViewController *wyjfVC = [[WuYeJiaoFeiViewController alloc] init];
        [self.navigationController pushViewController:wyjfVC animated:YES];
    }
    
}
@end
