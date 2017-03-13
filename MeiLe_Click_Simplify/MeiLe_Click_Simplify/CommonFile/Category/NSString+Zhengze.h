//
//  NSString+Zhengze.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/13.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Zhengze)

- (BOOL)isPhoneNumberString:(NSString *)number;

+ (BOOL)checkPassWordAndLenth: (NSString *) value;

@end
