//
//  NewsViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/15.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsListTableViewCell.h"

static NSString *identifier = @"NewsListTableViewCell";


@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息圈";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight - Navigation_Height) style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.rowHeight  = 60;
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewsListTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
