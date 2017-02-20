//
//  UserLoginModel.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "UserModel.h"

@interface UserLoginModel : UserModel

/**
 *  当前登录用户的TICKET、账号、密码，本地保存;
 */
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *ticket;

@end
