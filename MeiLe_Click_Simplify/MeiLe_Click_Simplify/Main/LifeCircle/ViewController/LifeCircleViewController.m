//
//  LifeCircleViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/14.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "LifeCircleViewController.h"
#import "SearchResultTVC.h"
#import "LifeCircleHeaderView.h"
#import "LifeCircleTableSectionView.h"

@interface LifeCircleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) UITableView        *tableView;

@end

@implementation LifeCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择小区";
    self.view.backgroundColor = [UIColor whiteColor];
    
    LifeCircleHeaderView *headerView = [[LifeCircleHeaderView alloc] initWithFrame:CGRectMake(0, 0, viewHeight, 178)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight - Navigation_Height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = headerView;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];;
    [self.view addSubview:_tableView];
    
    self.definesPresentationContext  = YES;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 124;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    LifeCircleTableSectionView *sectionView = [LifeCircleTableSectionView viewFromXIB];
    sectionView.frame = CGRectMake(0, 0, viewWidth, 124);
    return sectionView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    cell.textLabel.font      = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = RGB(70, 70, 70);
    cell.textLabel.text      = [NSString stringWithFormat:@"众美城%ld区",(long)indexPath.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
