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


static NSString *identifier = @"PersonCollectionViewCell";

@interface PersonViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) PersonTopView    *topView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    UIImage *topImage = [UIImage imageNamed:@"person_topBaseImage_1"];
    [self.navigationController.navigationBar setBackgroundImage:topImage forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    
  
    
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

@end
