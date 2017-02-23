//
//  ResolveConflicScrollView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/21.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "ResolveConflicScrollView.h"
#import "SHRollScrollView.h"

@implementation ResolveConflicScrollView

- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    if ([view isKindOfClass:NSClassFromString(@"SHRollScrollView")]) {
       
        return NO;
        
    } else {
        
        return [super touchesShouldBegin:touches withEvent:event inContentView:view];
    }
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ([view isKindOfClass:NSClassFromString(@"SHRollScrollView")]) {
       
        return NO;
        
    } else {
        
        return [super touchesShouldCancelInContentView:view];
    }
}


//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    
//    
//    CGPoint current = [touch locationInView:self];
//    
//    if (0 < current.x && current.x < viewWidth * 2 && current.y < viewWidth * 0.7) {
//        // 在地图上
//        return NO;
//    } else {
//        // 不在地图上
//        return YES;
//        
//    }
//    
//}

@end
