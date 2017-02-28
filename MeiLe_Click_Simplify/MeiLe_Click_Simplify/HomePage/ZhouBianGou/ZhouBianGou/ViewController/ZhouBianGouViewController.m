//
//  ZhouBianGouViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/22.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "ZhouBianGouViewController.h"
#import "SHRollScrollView.h"
#import "zhoubiangouTableViewCell.h"
#import "ShopListViewController.h"

static NSString *identifier = @"zhoubiangouTableViewCell";

#define SCROLLVIEW_HEIGHT 148

@interface ZhouBianGouViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ZhouBianGouViewController
{
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect tableFrame = CGRectMake(0, 0, viewWidth, self.view.bounds.size.height - Navigation_Height);
    _tableView.frame  = tableFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.rowHeight  = 70 + 10;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([zhoubiangouTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return SCROLLVIEW_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SHRollScrollView *scrollView = [[SHRollScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, SCROLLVIEW_HEIGHT)];
    scrollView.imageArray = @[@"homepage_zbg_scroll_0",@"homepage_zbg_scroll_0"];
    
    return scrollView;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    zhoubiangouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:[ShopListViewController new] animated:YES];
}
@end
