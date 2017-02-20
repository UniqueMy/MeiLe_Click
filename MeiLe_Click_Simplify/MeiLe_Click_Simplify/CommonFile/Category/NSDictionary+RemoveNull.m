//
//  NSDictionary+RemoveNull.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "NSDictionary+RemoveNull.h"
#import "NSArray+RemoveNull.h"

@implementation NSDictionary (RemoveNull)

- (id)dictionaryByRemovingNull
{
    return [self dictionaryByRemovingNullRecursively:YES];
}

- (id)dictionaryByRemovingNullRecursively:(BOOL)recursive
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:self];
    
    for (id key in [self allKeys]) {
        id object = [self objectForKey:key];
        
        if (object == [NSNull null]) {
            [dictionary removeObjectForKey:key];
        }
        
        if (recursive) {
            
            if ([object isKindOfClass:[NSDictionary class]]) {
                NSDictionary *subdictionary = [object dictionaryByRemovingNullRecursively:YES];
                [dictionary setValue:subdictionary forKey:key];
            }
            
            if ([object isKindOfClass:[NSArray class]]) {
                NSArray *subarray = [object arrayByRemovingNullRecursively:YES];
                [dictionary setValue:subarray forKey:key];
            }
        }
    }
    
    return [dictionary copy];
}


@end
