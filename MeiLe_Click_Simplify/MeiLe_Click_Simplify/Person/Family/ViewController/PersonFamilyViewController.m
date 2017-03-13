//
//  PersonFamilyViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/6.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "PersonFamilyViewController.h"
#import "FamilyHeaderView.h"
#import "FamilySectionView.h"
#import "FamilyMyTableViewCell.h"
#import "FamilyMeTableViewCell.h"

#define HeaderView_Height  42
#define SectionView_Height 163

static NSString *myIdentifier = @"FamilyMyTableViewCell";
static NSString *meIdentifier = @"FamilyMeTableViewCell";

@interface PersonFamilyViewController () <UITableViewDelegate,UITableViewDataSource,FamilyHeaderViewDelegate>

@property (nonatomic,strong) UITableView       *tableView;
@property (nonatomic,strong) FamilyHeaderView  *headerView;
@property (nonatomic,strong) FamilySectionView *sectionView;

@end

@implementation PersonFamilyViewController
{
    BOOL isMeCell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(244, 244, 244);
    self.navigationItem.title = @"我的家庭";
    
    [self addLeftBarItem];
    
    [self addselectView];
    
}

- (void)addLeftBarItem {
    
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(-10, 0, 22, 22)];
    [leftButton setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
}

- (void)backItemClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addselectView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight - Navigation_Height) style:UITableViewStylePlain];
    _tableView.delegate    = self;
    _tableView.dataSource  = self;
    _tableView.rowHeight   = 66;
    [self.view addSubview: _tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FamilyMyTableViewCell class]) bundle:nil] forCellReuseIdentifier:myIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FamilyMeTableViewCell class]) bundle:nil] forCellReuseIdentifier:meIdentifier];
    
    _headerView                = [FamilyHeaderView viewFromXIB];
    _headerView.frame          = CGRectMake(0, 0, viewWidth, HeaderView_Height);
    _headerView.delegate       = self;
    _tableView.tableHeaderView = _headerView;
}

- (void)reloadTableViewCellIsMe:(BOOL)isMe {
    
    isMeCell = isMe;
    
    [_tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (!isMeCell) {
        
        return SectionView_Height;
        
    } else {
        
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    _sectionView       = [FamilySectionView viewFromXIB];
    _sectionView.frame = CGRectMake(0, 0, viewWidth, SectionView_Height);
    return _sectionView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isMeCell) {
        FamilyMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        
        return cell;
    } else {
        
        FamilyMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:meIdentifier];
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
