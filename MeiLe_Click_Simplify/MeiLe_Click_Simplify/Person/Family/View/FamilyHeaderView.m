//
//  FamilyHeaderView.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/7.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "FamilyHeaderView.h"

@interface FamilyHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *MyButton;

@property (weak, nonatomic) IBOutlet UIButton *MeButton;

@property (weak, nonatomic) IBOutlet UIView *MoveView;

@end

@implementation FamilyHeaderView

+ (instancetype)viewFromXIB {
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    
    return views[0];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    
}
- (IBAction)MyButtonClick:(id)sender {
    
    [_MeButton setTitleColor:RGB(70, 70, 70)  forState:UIControlStateNormal];
    [_MyButton setTitleColor:RGB(180, 40, 45) forState:UIControlStateNormal];
    
    CGRect frame    = _MoveView.frame;
    frame.origin.x  = _MyButton.frame.origin.x;
    _MoveView.frame = frame;
    
    if ([_delegate respondsToSelector:@selector(reloadTableViewCellIsMe:)]) {
        
        [_delegate reloadTableViewCellIsMe:NO];
        
    }
    
}

- (IBAction)MeButtonClick:(id)sender {
    
    
    
    [_MeButton setTitleColor:RGB(180, 40, 45) forState:UIControlStateNormal];
    [_MyButton setTitleColor:RGB(70, 70, 70) forState:UIControlStateNormal];
    
    
    CGRect frame    = _MoveView.frame;
    frame.origin.x  = _MeButton.frame.origin.x;
    _MoveView.frame = frame;
    
    if ([_delegate respondsToSelector:@selector(reloadTableViewCellIsMe:)]) {
        
        [_delegate reloadTableViewCellIsMe:YES];
        
    }
}

@end
