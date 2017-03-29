//
//  HomePageViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/20.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "HomePageViewController.h"
#import "UserRequestModel.h"
#import "UIViewController+BarButton.h"
#import "ResolveConflicScrollView.h"
#import "ChangeTitleView.h"
#import "FuWuHuiViewController.h"
#import "WuYeTongViewController.h"
#import "ZhouBianGouViewController.h"
#import "LifeCircleViewController.h"

#import "JingDongViewController.h"

@interface HomePageViewController ()<UIScrollViewDelegate,ChangeTitleViewDelegate>

@property (nonatomic,strong) ResolveConflicScrollView *scrollView;
@property (nonatomic,strong) ChangeTitleView          *titleCollectView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 生活圈
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        CATransition *transition = [CATransition animation];
//        transition.duration = .3f;
//        transition.type    = kCATransitionPush;
//        transition.subtype = kCATransitionFromBottom;
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        self.navigationController.navigationBarHidden = NO;
//        
//        [self.navigationController pushViewController:[LifeCircleViewController new] animated:NO];
//        
//    });
    
    /**
     添加左视图 -- 扫描
     */
    [self addLeftScanQRCodeBarButtonItem];
    
    /**
     添加右视图 -- 消息
     */
    [self addRightNewsBarButtonItemWithAlreadyRead:NO];
    
    [self createUI];
}

- (void)createUI {
    
    NSArray *titleArray = @[@"周边购",@"物业通",@"服务汇"];
    _titleCollectView   = [[ChangeTitleView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 40)];
    _titleCollectView.dataArray = titleArray;
    _titleCollectView.delegate  = self;
    [_titleCollectView selectedTitle:0];
    [self.view addSubview:_titleCollectView];
    
    _scrollView = [[ResolveConflicScrollView alloc] init];
    _scrollView.frame = CGRectMake(0,
                                   CGRectGetMaxY(_titleCollectView.frame),
                                   viewWidth,
                                   viewHeight - 90);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize   = CGSizeMake(viewWidth * titleArray.count, viewHeight - 90);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces  = NO;
    _scrollView.delegate = self;
    _scrollView.decelerationRate     = 0.2;
    _scrollView.delaysContentTouches = YES;
   
    _scrollView.scrollEnabled = YES;
    [self.view addSubview: _scrollView];
    
    ZhouBianGouViewController *zhoubiangouVC = [[ZhouBianGouViewController alloc] init];
    zhoubiangouVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
    [self addChildViewController:zhoubiangouVC];
    [self.scrollView addSubview:zhoubiangouVC.view];
    
    WuYeTongViewController *wuyetongVC = [[WuYeTongViewController alloc] init];
    [self addChildViewController:wuyetongVC];
    wuyetongVC.view.frame = CGRectMake(viewWidth, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
    [self.scrollView addSubview:wuyetongVC.view];
    
    FuWuHuiViewController *fuwuhuiVC = [[FuWuHuiViewController alloc] init];
    [self addChildViewController:fuwuhuiVC];
    fuwuhuiVC.view.frame = CGRectMake(viewWidth * 2, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
    [self.scrollView addSubview:fuwuhuiVC.view];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger number = scrollView.contentOffset.x / viewWidth;
    [_titleCollectView selectedTitle:number];
}

- (void)didClickTitleIndex:(NSInteger)index {
    
    [_scrollView setContentOffset:CGPointMake(index*viewWidth, 0) animated:YES];
}



@end
