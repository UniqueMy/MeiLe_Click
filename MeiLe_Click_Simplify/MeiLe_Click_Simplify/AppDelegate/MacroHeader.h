//
//  MacroHeader.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#ifndef MacroHeader_h
#define MacroHeader_h

#import <UIKit/UIKit.h>

#define DEV_ENV 0 //1的时候是上传至appstore 用的key

#if DEV_ENV
static NSString *const  HTTP_BASE_HOST = @"http://139.129.236.21"; // 生产
#else
static NSString *const  HTTP_BASE_HOST = @"http://114.215.96.146"; // 测试
#endif

#define viewWidth      [UIScreen mainScreen].bounds.size.width     // 屏幕宽度
#define viewHeight     [UIScreen mainScreen].bounds.size.height    // 屏幕高度

#define Navigation_Height  64
#define RGBA(r,g,b,a)      [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]
#define RGB(r,g,b)         [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1]

#define USER_ADMIN_TICKET_KEY         @"com.hdzc.tenement.user.admin.ticket"
#define USER_ADMIN_LOGINNAME_KEY      @"com.hdzc.tenement.user.admin.name"
#define USER_ADMIN_PASSWORD_KEY       @"com.hdzc.tenement.user.admin.password"
#define USER_ADMIN_IMGHOST_KEY        @"com.hdzc.tenement.user.admin.imghost"
#define USER_ADMIN_FRONTURL_KEY       @"com.hdzc.tenement.user.admin.frontUrl"

// 用于缓存的用户信息
#define USER_MODEL_CACHE_KEY          @"com.hdzc.tenement.user.model.cache"


#define HTTP_SESSION_ID               @"com.hdzc.tenement.http.session.id"
#define HTTP_APP_VERSION              @"1.1.0"
#define HTTP_APP_OS                   @"ios"
#define HTTP_APP_ID                   @"ZM_YH"
#define HTTP_AES_KEY                  @"com.hdzc.tenement.aeskey" 












#endif /* MacroHeader_h */
