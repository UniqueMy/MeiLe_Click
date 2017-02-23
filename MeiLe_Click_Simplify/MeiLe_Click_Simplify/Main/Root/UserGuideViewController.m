//
//  UserGuideViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "UserGuideViewController.h"
#import "RootViewController.h"

@interface UserGuideViewController ()

@end

@implementation UserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showIntroWithCrossDissolve];
}

- (void)showIntroWithCrossDissolve {
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage      = [UIImage imageNamed:@"guide_0"];
    
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage      = [UIImage imageNamed:@"guide_1"];
    
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage      = [UIImage imageNamed:@"guide_2"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    [intro setDelegate:self];
    
    [intro showInView:self.view animateDuration:0.3];
}

- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    
    [RootViewController presentViewControllerType:RootViewControllerTypeLogin];
}


@end
