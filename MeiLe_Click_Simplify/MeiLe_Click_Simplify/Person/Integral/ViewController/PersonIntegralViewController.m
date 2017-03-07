//
//  PersonIntegralViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/6.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "PersonIntegralViewController.h"
#import "IntegralHtmlViewController.h"
#import "IntegralTopView.h"
#import "IntegralTableViewCell.h"

#define TopView_Height 149
static NSString *identifier = @"IntegralTableViewCell";

@interface PersonIntegralViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) IntegralTopView *topView;
@property (nonatomic,strong) UITableView     *tableView;

@end

@implementation PersonIntegralViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(70, 70, 70),NSFontAttributeName:[UIFont systemFontOfSize:16]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"积分";
    
    [self addRightBarItem];
    
    [self addTopView];
    
    [self addTableView];
    
}

- (void)addRightBarItem {
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"person_integral_rightIcon"] style:UIBarButtonItemStyleDone target:self action:@selector(integralClick)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)integralClick {
    
    IntegralHtmlViewController *htmlVC = [[IntegralHtmlViewController alloc] init];
    [self.navigationController pushViewController:htmlVC animated:YES];
}

- (void)addTopView {
    
    _topView = [IntegralTopView viewFromXIB];
    _topView.frame = CGRectMake(0, 0, viewWidth, TopView_Height);
    [self.view addSubview:_topView];
}

- (void)addTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TopView_Height , viewWidth, viewHeight - TopView_Height - Navigation_Height) style:UITableViewStylePlain];
    _tableView.rowHeight       = 60;
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
//    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([IntegralTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle         = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
