//
//  ChangeTitleView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/21.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "ChangeTitleView.h"
#import "TitleCollectionViewCell.h"

static NSString *identifier = @"titleButtonCell";

@implementation ChangeTitleView
{
    CGSize                      viewSize;
    NSMutableArray             *dataSouce;
    UICollectionViewFlowLayout *layout;
    UICollectionView           *collection;
    UIView                     *moveView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        viewSize  = frame.size;
        dataSouce = [NSMutableArray array];
        [self createUI];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
    [dataSouce removeAllObjects];
    [dataSouce addObjectsFromArray:dataArray];
    
    [self createUI];
}

- (void)createUI {
    
    layout          = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(viewWidth / 3, 40);
    layout.minimumLineSpacing      = 0;
    layout.minimumInteritemSpacing = 0;
    
    collection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collection.backgroundColor = RGBA(249, 249, 249,0.8);
    collection.showsHorizontalScrollIndicator = NO;
    collection.dataSource = self;
    collection.delegate   = self;
    [self addSubview: collection];
    
    [collection registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    moveView                 = [[UIView alloc] init];
    moveView.backgroundColor = RGB(180, 40, 45);
    [self addSubview:moveView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  dataSouce.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TitleCollectionViewCell *cell = [collection dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    moveView.frame = CGRectMake((cell.bounds.size.width -59) / 2, cell.bounds.size.height - 2, 59, 2);
    cell.titleLabel.text = dataSouce[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TitleCollectionViewCell *cell = (TitleCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    moveView.frame = CGRectMake(cell.frame.origin.x + (cell.bounds.size.width -59) / 2,
                                cell.bounds.size.height - 2,
                                59,
                                2);
    
    if (self.delegate) {
        [self.delegate didClickTitleIndex:indexPath.row];
    }
}

- (void)selectedTitle:(NSInteger)number {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:number inSection:0];
    
    TitleCollectionViewCell *cell = (TitleCollectionViewCell *)[collection cellForItemAtIndexPath:indexPath];
    
    moveView.frame = CGRectMake(cell.frame.origin.x + (cell.bounds.size.width -59) / 2,
                                cell.bounds.size.height - 2,
                                59,
                                2);
    
    [collection selectItemAtIndexPath:[NSIndexPath indexPathForRow:number inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

@end
