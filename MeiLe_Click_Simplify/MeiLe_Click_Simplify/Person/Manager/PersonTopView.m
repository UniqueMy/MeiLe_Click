//
//  PersonTopView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/6.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "PersonTopView.h"

@implementation PersonTopView

+ (instancetype)viewFromXIB {
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    
    return views[0];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.headImage.layer.cornerRadius  = self.headImage.bounds.size.width / 2;
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImage.layer.borderWidth = 1.f;
    
    
}
- (IBAction)setMessageClick:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(pushMessageView)]) {
        
        [_delegate pushMessageView];
    }
    
}



@end
