//
//  PersonViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/20.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonTopView.h"
#import "UIViewController+BarButton.h"
#import "PersonCollectionViewCell.h"
#import "PersonIntegralViewController.h"
#import "PersonShoppingViewController.h"
#import "PersonWareHouseViewController.h"
#import "PersonFamilyViewController.h"
#import "PersonAddressViewController.h"
#import "PersonRecordViewController.h"
#import "PersonFeedbackViewController.h"
#import "PersonQRCodeViewController.h"
#import "PersonSetViewController.h"
#import "PersonBaseInfoViewController.h"

#import "UINavigationBar+Image.h"


static NSString *identifier = @"PersonCollectionViewCell";

@interface PersonViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) PersonTopView    *topView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     添加左视图 -- 扫描
     */
    [self addLeftScanQRCodeBarButtonItemIsPerson:YES];
    
    /**
     添加右视图 -- 消息
     */
    [self addRightNewsBarButtonItemWithAlreadyRead:NO isPerson:YES];
    
    [self loadTopViewFromXIB];
    
    [self createUI];
    
    self.navigationItem.title = @"众美城A区";
    
}

- (void)loadTopViewFromXIB {
    
    self.topView  = [PersonTopView viewFromXIB];
    self.topView.frame = CGRectMake(0, 0, viewWidth, 121);
    [self.view addSubview:self.topView];
    
}

- (void)createUI {
    
    _flowLayout          = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake((viewWidth - 3) / 3, (viewWidth - 3) / 3);
    _flowLayout.minimumLineSpacing      = 1;
    _flowLayout.minimumInteritemSpacing = 1;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 128, viewWidth, viewHeight - Navigation_Height - 128 - Tabbar_Height) collectionViewLayout:_flowLayout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = RGB(244, 244, 244);
    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PersonCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSArray *titleArray  = @[@"积分",@"我的购物",@"仓储提货",@"我的家庭",@"收货地址",@"服务记录",@"意见反馈",@"二维码",@"设置"];
    cell.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"person_icon_%ld",(long)indexPath.row]];
    cell.iconLabel.text  = titleArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexPath %ld",(long)indexPath.row);
    
    switch (indexPath.row) {
        case 0:
        {
            PersonIntegralViewController *integral = [[PersonIntegralViewController alloc] init];
            [self.navigationController pushViewController:integral animated:YES];
            
        }
            break;
        case 1:
        {
            PersonShoppingViewController *shopping = [[PersonShoppingViewController alloc] init];
            [self.navigationController pushViewController:shopping animated:YES];
        }
            break;
        case 2:
        {
            PersonWareHouseViewController *warehouse = [[PersonWareHouseViewController alloc] init];
            [self.navigationController pushViewController:warehouse animated:YES];
        }
            break;
        case 3:
        {
            PersonFamilyViewController *family = [[PersonFamilyViewController alloc] init];
            [self.navigationController pushViewController:family animated:YES];
        }
            break;
        case 4:
        {
            PersonAddressViewController *address = [[PersonAddressViewController alloc] init];
            [self.navigationController pushViewController:address animated:YES];
        }
            break;
        case 5:
        {
            PersonRecordViewController *record = [[PersonRecordViewController alloc] init];
            [self.navigationController pushViewController:record animated:YES];
        }
            break;
        case 6:
        {
            PersonFeedbackViewController *feedback = [[PersonFeedbackViewController alloc] init];
            [self.navigationController pushViewController:feedback animated:YES];
        }
            break;
        case 7:
        {
            PersonQRCodeViewController *QRCode = [[PersonQRCodeViewController alloc] init];
            [self.navigationController pushViewController:QRCode animated:YES];
        }
            break;
        case 8:
        {
            PersonSetViewController *set = [[PersonSetViewController alloc] init];
            [self.navigationController pushViewController:set animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)changeNavigationBackgroundImage {
    
    UIImage *topImage = [UIImage imageNamed:@"person_topBaseImage_1"];
    
    [self.navigationController.navigationBar setCustomNavigationBarWithImage:topImage];
   
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self changeNavigationBackgroundImage];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setResultNavigationBar];
}

@end
