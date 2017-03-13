//
//  UserRequestModel.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "UserRequestModel.h"
#import "UserLoginModel.h"


@implementation UserRequestModel

static UserLoginModel * userLoginModel;

/**
 * 将用户所有信息封装成UserLoginModel 本地保存
 *
 * @param userLogin 用户信息
 */
+ (void)setUserLogin:(UserLoginModel *)userLogin {
    
    userLoginModel = userLogin;
    
    if (userLoginModel) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[userLoginModel yy_modelToJSONString] forKey:USER_MODEL_CACHE_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

/**
 *  获取用户所有信息的Model
 *
 *  @return UserLoginModel
 */
+ (UserLoginModel *)getUserLogin
{
    if (!userLoginModel) {
        NSString *userJSONStr = [[NSUserDefaults standardUserDefaults] objectForKey:USER_MODEL_CACHE_KEY];
        userLoginModel = [UserLoginModel yy_modelWithJSON:userJSONStr];
    }
    
    return userLoginModel;
}

/**
 *  登录检查,判断是否需要重新登录
 *  true 需要跳转到登录
 */
+ (void)checkUserNeedLogin:(CheckLoginSuccess)checkResult failure:(CheckLoginFailure)failture {
    
    // 从本地获取用户登录信息
    NSString *userName = [self getUserLogin].userName;
    NSString *password = [self getUserLogin].password;
    
    
    
    if (!userName || !password) {
        // 需要登录
        checkResult(YES);
        return;
    }
    // 发起请求检查是否需要登录
    NSDictionary *parameters = @{@"loginName":userName,
                                 @"password":password};
    
    [UserRequestModel requestLoginWithDictionary:parameters success:^(NSString *path, NSDictionary *responseJson, id responseBody, NSInteger code) {
        
        checkResult(NO);
        
    } failure:^(NSString *path, NSError *error) {
        
        failture(error);
        
    }];
}

+ (void)requestLoginWithDictionary:(NSDictionary *)parameters success:(HttpRequestBlockType_Success)requestSuccess failure:(HttpRequestBlockType_Failure)requestFailure {
    
    [[HttpRequest sharedInstance] userLogindictionary:parameters success:^(NSString *path, NSDictionary *responseJson, id responseBody, NSInteger code) {
        
        // 将ticket、账号、密码 写入本地
        NSString *ticket    = [responseJson objectForKey:@"data"];
        [[NSUserDefaults standardUserDefaults] setObject:ticket forKey:USER_ADMIN_TICKET_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 查询用户所有信息
        [[HttpRequest sharedInstance] baseRequestNeedTicketCommonWithUrl:@"/tenement-service/user/user.selectSysUser.json" body_data:nil success:^(NSString *path, NSDictionary *responseJson, id responseBody, NSInteger code) {
            
            NSDictionary *userModelDict = [responseBody objectForKey:@"data"];
            
            UserLoginModel *userLoginModel = [UserLoginModel yy_modelWithDictionary:userModelDict];
            [userLoginModel setTicket:ticket];
            
           
            
            [userLoginModel setUserName:parameters[@"loginName"]];
            [userLoginModel setPassword:parameters[@"password"]];
            [UserRequestModel setUserLogin:userLoginModel];
            
             requestSuccess(path,responseJson,responseBody,code);
            
        } fail:^(NSString *path, NSError *error) {
            
        }];
        
       
        
    } fail:^(NSString *path, NSError *error) {
        
    }];
}

/**
 请求验证码
 
 @param phoneNumber 电话号码
 @param completedBlock 是否成功 返回信息
 */
+ (void)sendCaptcha:(NSString *)phoneNumber completed:(void(^)(BOOL isSuccess))completedBlock {
    
    [[HttpRequest sharedInstance] baseRequestNeedTicketCommonWithUrl:@"/tenement-service/user/user.sendCaptchas.json" body_data:@{@"mobilePhone" : phoneNumber} success:^(NSString *path, NSDictionary *responseJson, NSDictionary *responseBody, NSInteger code) {
        
        completedBlock(true);
        
    } fail:^(NSString *path, NSError *error) {
        
    }];
    
}

@end
