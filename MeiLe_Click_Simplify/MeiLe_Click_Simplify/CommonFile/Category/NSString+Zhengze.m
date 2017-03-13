//
//  NSString+Zhengze.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/13.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "NSString+Zhengze.h"

@implementation NSString (Zhengze)

- (BOOL)isPhoneNumberString:(NSString *)number
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^1[3|4|5|7|8][0-9][0-9]{8}$"
                                              options :NSRegularExpressionCaseInsensitive
                                              error   :nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:number
                                                                 options :NSMatchingReportProgress
                                                                 range   :NSMakeRange(0, number.length)];
    
    if(numberofMatch > 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)checkPassWordAndLenth: (NSString *) value {
    NSString *pattern = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:value];
    return isMatch;
}

@end
