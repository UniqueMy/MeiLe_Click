//
//  UserLoginModel.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "UserLoginModel.h"

@implementation UserLoginModel

-(void)setTicket:(NSString *)ticket
{
    if ([ticket isKindOfClass:[NSString class]] && ticket.length) {
        [[NSUserDefaults standardUserDefaults] setObject:ticket forKey:USER_ADMIN_TICKET_KEY];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ADMIN_TICKET_KEY];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    _ticket = ticket;
    
}

- (void)setUserName:(NSString *)userName
{
    if ([userName isKindOfClass:[NSString class]] && userName.length) {
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:USER_ADMIN_LOGINNAME_KEY];
      
    } else {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ADMIN_LOGINNAME_KEY];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    _userName = userName;
}

-(void)setPassword:(NSString *)password
{
    if ([password isKindOfClass:[NSString class]] && password.length) {
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:USER_ADMIN_PASSWORD_KEY];
    }else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ADMIN_PASSWORD_KEY];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    _password = password;
}


@end
