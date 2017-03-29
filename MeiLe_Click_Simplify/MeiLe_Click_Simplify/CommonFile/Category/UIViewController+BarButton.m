//
//  UIViewController+BarButton.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/21.
//  Copyright © 2017年 ShengHao. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "UIViewController+BarButton.h"
#import "ScanQRCodeViewController.h"
#import "NewsViewController.h"

#import <objc/runtime.h>

static NSString const *_newsButton = @"rightNewsButton";

@implementation UIViewController (BarButton)


/**
 Runtime 给分类添加属性
 
 @return UIButton
 */
- (UIButton *)newsButton {
    
    return objc_getAssociatedObject(self, &_newsButton);
}

- (void)setNewsButton:(UIButton *)newsButton {
    
    objc_setAssociatedObject(self, &_newsButton, newsButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/**
 添加左视图 -- 扫描
 */
- (void)addLeftScanQRCodeBarButtonItem {
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    
    UIImage *image =  [UIImage imageNamed:@"common_scan"];
    
    [leftButton setImage:image forState:UIControlStateNormal];;
    [leftButton addTarget:self action:@selector(scanCodeController) forControlEvents:UIControlEventTouchUpInside];
    
    leftButton.imageEdgeInsets     = UIEdgeInsetsMake(0, 0, 0, 0);
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
}

- (void)scanCodeController {
    
    //读取媒体类型
    NSString *mediaType = AVMediaTypeVideo;
    //读取设备授权状态
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==  AVAuthorizationStatusDenied) {
        NSString *errorStr = @"应用相机权限受限,请在设置中启用";
        [SVProgressHUD showInfoWithStatus:errorStr];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    
    ScanQRCodeViewController *scanVC = [[ScanQRCodeViewController alloc] init];
    [self.navigationController pushViewController:scanVC animated:YES];
}

/**
 添加右视图 -- 消息
 */
- (void)addRightNewsBarButtonItemWithAlreadyRead:(BOOL)isRead {
    
    if (!self.newsButton) {
        UIImage *image =  [UIImage imageNamed:@"common_news_no"];
        
        self.newsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        [self.newsButton setImage:image forState:UIControlStateNormal];;
        [self.newsButton addTarget:self action:@selector(onMessageButtonTouchAction:) forControlEvents:UIControlEventTouchUpInside];
        self.newsButton.imageEdgeInsets   = UIEdgeInsetsMake(0, 0, 0, 0);
        UIBarButtonItem *rightBurButton = [[UIBarButtonItem alloc] initWithCustomView:self.newsButton];
        self.navigationItem.rightBarButtonItem = rightBurButton;
    }
    
    if (isRead) {
        UIImage *image = [UIImage imageNamed:@"common_news_yes"];
        
        [self.newsButton setImage:image forState:UIControlStateNormal];
    } else {
        UIImage *image = [UIImage imageNamed:@"common_news_no"];
        [self.newsButton setImage:image forState:UIControlStateNormal];
    }
}

- (void)onMessageButtonTouchAction:(id)sender {
    
    NewsViewController *news = [[NewsViewController alloc] init];
    [self.navigationController pushViewController:news animated:YES];
}
@end
