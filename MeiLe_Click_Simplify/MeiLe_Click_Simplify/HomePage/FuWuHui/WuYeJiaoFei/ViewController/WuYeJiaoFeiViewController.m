//
//  WuYeJiaoFeiViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/9.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "WuYeJiaoFeiViewController.h"

@interface WuYeJiaoFeiViewController ()

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *monthButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseHouseButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *payMoneyButton;

@end

@implementation WuYeJiaoFeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"物业缴费";
    
    [HttpRequest bezierPathWithView:_topView        corners:UIRectCornerAllCorners radii:CGSizeMake(4, 4)];
    [HttpRequest bezierPathWithView:_bottomView     corners:UIRectCornerAllCorners radii:CGSizeMake(4, 4)];
    [HttpRequest bezierPathWithView:_recordButton   corners:UIRectCornerAllCorners radii:CGSizeMake(4, 4)];
    [HttpRequest bezierPathWithView:_payMoneyButton corners:UIRectCornerAllCorners radii:CGSizeMake(4, 4)];
    _monthButton.layer.cornerRadius = 2;
    _monthButton.layer.masksToBounds = YES;
    _monthButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _monthButton.layer.borderWidth = .5f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
