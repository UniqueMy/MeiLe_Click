//
//  NSArray+RemoveNull.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (RemoveNull)

- (id)arrayByRemovingNull;
- (id)arrayByRemovingNullRecursively:(BOOL)recursive;

@end
