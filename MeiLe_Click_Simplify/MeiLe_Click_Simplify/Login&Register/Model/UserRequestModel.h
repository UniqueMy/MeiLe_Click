//
//  UserRequestModel.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserLoginModel.h"

typedef void(^CheckLoginSuccess)  (BOOL needLogin);
typedef void(^CheckLoginFailure)  (NSError *error);
typedef void(^HttpRequestBlockType_Success)(NSString *path,NSDictionary *responseJson,NSDictionary *responseBody,NSInteger code);
typedef void(^HttpRequestBlockType_Failure)(NSString *path,NSError *error);


@interface UserRequestModel : NSObject

/**
 *  获取登录用户信息
 *
 *  @return return value description
 */
+ (UserLoginModel *)getUserLogin;

/**
 *  保存用户信息
 *
 *  @param user user
 */
+ (void)setUserLogin:(UserLoginModel *)user;

/**
 *  登录检查,判断是否需要重新登录
 *  true 需要跳转到登录
 */
+ (void)checkUserNeedLogin:(CheckLoginSuccess)checkResult failure:(CheckLoginFailure)failture;


/**
 发起登录

 @param parameters 传入账号密码
 @param success
 @param failure 
 */
+ (void)requestLoginWithDictionary:(NSDictionary *)parameters success:(HttpRequestBlockType_Success)requestSuccess failure:(HttpRequestBlockType_Failure)requestFailure;
@end
