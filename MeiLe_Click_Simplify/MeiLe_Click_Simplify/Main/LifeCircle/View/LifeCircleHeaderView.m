//
//  LifeCircleHeaderView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/14.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "LifeCircleHeaderView.h"
#import "SearchResultTVC.h"
#import "LifecircleCollectionHeaderView.h"
#import "LifecircleCollectionViewCell.h"



static NSString *identifier = @"LifecircleCollectionViewCell";

@interface LifeCircleHeaderView ()<UISearchBarDelegate,UISearchControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UISearchController         *searchController;
@property (nonatomic,strong) UICollectionView           *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;


@end

@implementation LifeCircleHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadSearchView];
        [self loadCollectionView];
    }
    return self;
}

- (void)loadSearchView {
    
    SearchResultTVC *resultTVC = [[SearchResultTVC alloc] init];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:resultTVC];
    _searchController.searchBar.frame = CGRectMake(0, 0, viewWidth, 44);
    
    _searchController.searchBar.searchBarStyle  = UISearchBarStyleMinimal;
    _searchController.searchBar.backgroundColor = [UIColor whiteColor];
    _searchController.searchBar.placeholder     = @"请输入地址";
    _searchController.searchBar.delegate        = self;
    _searchController.delegate                  = self;
    [self addSubview:_searchController.searchBar];
    
    
}

- (void)loadCollectionView {
    
    _flowLayout          = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake((viewWidth - 16*4) / 3, 30);
    _flowLayout.headerReferenceSize = CGSizeMake(viewWidth, 38);
    _flowLayout.sectionInset = UIEdgeInsetsMake(12, 16, 0, 16);
    _flowLayout.minimumLineSpacing      = 12;
    _flowLayout.minimumInteritemSpacing = 16;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, viewWidth, 134) collectionViewLayout:_flowLayout];
    _collectionView.delegate        = self;
    _collectionView.dataSource      = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LifecircleCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    
    [_collectionView registerClass:[LifecircleCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 5;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    LifecircleCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    
    return headerView;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LifecircleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
   
}
@end
