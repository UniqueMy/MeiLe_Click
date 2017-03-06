//
//  UIViewController+BarButton.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/21.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIViewController (BarButton)

/**
 添加左视图 -- 扫描
 */
- (void)addLeftScanQRCodeBarButtonItemIsPerson:(BOOL)isperson;

/**
 添加右视图 -- 消息
 */
@property (nonatomic,strong) UIButton *newsButton;

- (void)addRightNewsBarButtonItemWithAlreadyRead:(BOOL)isRead isPerson:(BOOL)isperson;
@end
