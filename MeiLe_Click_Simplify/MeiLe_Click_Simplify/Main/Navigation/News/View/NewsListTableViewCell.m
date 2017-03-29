//
//  NewsListTableViewCell.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/15.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "NewsListTableViewCell.h"

@implementation NewsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGRect frame = _newsNumber.frame;
    
    frame.origin.x = 200;
    _newsNumber.frame = frame;
//    
//    NSLog(@"_newsNumber.text.length %lu",_newsNumber.text.length);
//    switch (_newsNumber.text.length) {
//        case 0:
//        {
//            frame.size.width  = 0;
//            frame.size.height = 0;
//        }
//            break;
//        case 1:
//        {
//            frame.size.width  = 34;
//            frame.size.height = 17;
//        }
//            break;
//        case 2:
//        {
//            frame.size.width  = 24;
//            frame.size.height = 17;
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    _newsNumber.frame = frame;
//    
//    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_newsNumber.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(_newsNumber.bounds.size.width / 2, _newsNumber.bounds.size.width / 2)];
//    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame         = _newsNumber.bounds;
//    maskLayer.path          = maskPath.CGPath;
//    _newsNumber.layer.mask         = maskLayer;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
