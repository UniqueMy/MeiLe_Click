//
//  PersonSignatureViewController.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/21.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonSignatureDelegate <NSObject>

- (void)saveSignatureWithString:(NSString *)string;

@end

@interface PersonSignatureViewController : UIViewController

@property (nonatomic,strong) NSString *signatureString;
@property (nonatomic,weak) id <PersonSignatureDelegate> delegate;

@end
