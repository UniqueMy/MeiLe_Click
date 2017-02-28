//
//  UIButton+Badge.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/28.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "UIButton+Badge.h"
#import <objc/runtime.h>

NSString const *UIButton_badgeKey      = @"UIButton_badgeKey";
NSString const *UIButton_badgeValueKey = @"UIButton_badgeValueKey";


@implementation UIButton (Badge)

- (UILabel *)badge {
    
    return objc_getAssociatedObject(self, &UIButton_badgeKey);
}

- (void)setBadge:(UILabel *)badge {
    
    objc_setAssociatedObject(self, &UIButton_badgeKey, badge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**************************************************************************************************/

- (NSString *)badgeValue {
    
    return objc_getAssociatedObject(self, &UIButton_badgeValueKey);
}

- (void)setBadgeValue:(NSString *)badgeValue {
    
    objc_setAssociatedObject(self, &UIButton_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (!badgeValue || ([badgeValue isEqualToString:@"0"])) {
        
        [self removeBadge];
        
    } else if (!self.badge) {
        
        [self initBadgeLabel];
    }
}

- (void)initBadgeLabel {
    
    CGRect labelFrame = CGRectMake(self.frame.size.width - self.badge.frame.size.width - 11,
                                   0,
                                   22,
                                   22);
    
    self.badge = [[UILabel alloc] initWithFrame:labelFrame];
    self.badge.backgroundColor = BaseCommonRedColor;
    self.badge.textColor       = [UIColor whiteColor];
    self.badge.font            = [UIFont systemFontOfSize:11];
    self.badge.textAlignment   = 1;
    self.badge.text            = self.badgeValue;
    [self addSubview:self.badge];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.badge.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(11, 11)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame         = self.badge.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.badge.layer.mask   = maskLayer;
    
}

- (void)removeBadge
{
    [UIView animateWithDuration:0.2 animations:^{
        
        self.badge.transform = CGAffineTransformMakeScale(0, 0);
        
    } completion:^(BOOL finished) {
        
        [self.badge removeFromSuperview];
        self.badge = nil;
    }];
}


@end
