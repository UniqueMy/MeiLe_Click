//
//  ResolveConflicScrollView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/21.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "ResolveConflicScrollView.h"
#import "SHRollScrollView.h"

#define MapHeight  215
#define SCROLLVIEW_HEIGHT 148

@implementation ResolveConflicScrollView

//- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
//{
//    NSLog(@"view %@",view.class);
//    if ([view isKindOfClass:NSClassFromString(@"SHRollScrollView")] || [view isKindOfClass:NSClassFromString(@"TapDetectingView")]) {
//       
//        return YES;
//        
//    } else {
//        
//        return [super touchesShouldBegin:touches withEvent:event inContentView:view];
//    }
//}
//
//- (BOOL)touchesShouldCancelInContentView:(UIView *)view
//{
//    if ([view isKindOfClass:NSClassFromString(@"SHRollScrollView")] || [view isKindOfClass:NSClassFromString(@"TapDetectingView")]) {
//       
//        return NO;
//        
//    } else {
//        
//        return [super touchesShouldCancelInContentView:view];
//    }
//}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    
    CGPoint current = [touch locationInView:self];
    
    if ((0 < current.x  && current.x < viewWidth * 2 && current.y <= SCROLLVIEW_HEIGHT) || (viewWidth < current.x  && current.x < viewWidth * 2 && current.y <= MapHeight)) {
        // 在地图上
        return NO;
    } else {
        // 不在地图上
        return YES;
        
    }
    
}

@end
