//
//  ShopViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/27.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "ShopViewController.h"
#import "TitleTableViewCell.h"
#import "UIButton+Badge.h"
#import "ContentTableViewCell.h"

#define TITLEWIDTH   86
#define CONTENTWIDTH viewWidth - 86

static NSString *titleIdentifier   = @"TitleTableViewCell";
static NSString *contentIdentifier = @"ContentTableViewCell";

typedef NS_ENUM(NSInteger,TableView_Type) {
    TableViewType_Title,
    TableViewType_Content,
    
};

@interface ShopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *titleTableView;
@property (nonatomic,strong) UITableView *contentTableView;
@property (nonatomic,strong) UIButton    *shopCar;

@end

@implementation ShopViewController

- (UIButton *)shopCar {
    
    if (!_shopCar) {
        _shopCar = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _shopCar.frame = CGRectMake(viewWidth - 42 - 16,
                                    viewHeight - 42 - 40 - Navigation_Height,
                                    42,
                                    42);
        [_shopCar setBackgroundImage:[UIImage imageNamed:@"homepage_zbg_shopcar"] forState:UIControlStateNormal];
        [self.view addSubview:_shopCar];
    }
    return _shopCar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"家政服务";
    
    _titleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TITLEWIDTH, viewHeight - Navigation_Height) style:UITableViewStylePlain];
    _titleTableView.backgroundColor = RGB(248, 248, 248);
    _titleTableView.rowHeight  = 48;
    _titleTableView.delegate   = self;
    _titleTableView.dataSource = self;
    _titleTableView.tag        = TableViewType_Title;
    _titleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_titleTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TitleTableViewCell class]) bundle:nil] forCellReuseIdentifier:titleIdentifier];
    [self.view addSubview:_titleTableView];
    
    _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(TITLEWIDTH, 0, CONTENTWIDTH, viewHeight - Navigation_Height) style:UITableViewStylePlain];
    _contentTableView.rowHeight  = 96;
    _contentTableView.delegate   = self;
    _contentTableView.dataSource = self;
    _contentTableView.tag        = TableViewType_Content;
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ContentTableViewCell class]) bundle:nil] forCellReuseIdentifier:contentIdentifier];
    [self.view addSubview:_contentTableView];
    
    self.shopCar.badgeValue = @"1";
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == TableViewType_Title) {
        
        return 4;
        
    } else if (tableView.tag == TableViewType_Content) {
        
        return 10;
        
    } else {
        
        return 0;
    };
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == TableViewType_Title) {
        
        TitleTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:titleIdentifier forIndexPath:indexPath];
        
        [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        return titleCell;
        
    } else if (tableView.tag == TableViewType_Content) {
        
        ContentTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:contentIdentifier forIndexPath:indexPath];
        
        [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        return contentCell;
        
    } else {
        
        return nil;
    };
    
   
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
}


@end
