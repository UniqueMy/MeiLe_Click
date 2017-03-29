//
//  PersonFamilyAddressViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/21.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "PersonFamilyAddressViewController.h"
#import "LifeCircleViewController.h"

@interface PersonFamilyAddressViewController ()

@property (weak, nonatomic) IBOutlet UIButton *sctionButton;

@end

@implementation PersonFamilyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"家庭住址";
    
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitleColor:RGB(208, 101, 86) forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)save {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)sectionButtonClick:(id)sender {
    
    LifeCircleViewController *lifeCircleVC = [[LifeCircleViewController alloc] init];
    [self.navigationController pushViewController:lifeCircleVC animated:YES];
}


@end
