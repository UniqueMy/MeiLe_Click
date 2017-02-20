//
//  NSDictionary+RemoveNull.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (RemoveNull)

- (id)dictionaryByRemovingNull;
- (id)dictionaryByRemovingNullRecursively:(BOOL)recursive;

@end
