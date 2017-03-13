//
//  ReferenceViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/13.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "ReferenceViewController.h"
#import "RootViewController.h"
#import "NSString+Zhengze.h"

@interface ReferenceViewController ()

@property (weak, nonatomic) IBOutlet UIButton *submit;

@property (weak, nonatomic) IBOutlet UITextField *referenceTextField;

@end

@implementation ReferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HttpRequest bezierPathToLayerRadiusWithView:_submit];
}
- (IBAction)jump:(id)sender {
    
     [RootViewController presentViewControllerType:RootViewControllerTypeMainView];
}

- (IBAction)submit:(id)sender {
    
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setBackgroundColor:RGBA(0, 0, 0, 0.6)];
    
        if (_referenceTextField.text.length == 0) {
    
            [SVProgressHUD showImage:nil status:@"手机号不能为空"];
            return;
        }
    
        if (![_referenceTextField.text isPhoneNumberString:_referenceTextField.text]) {
    
            [SVProgressHUD showImage:nil status:@"请输入正确的手机号码"];
            return;
        }
    
    [[HttpRequest sharedInstance] baseRequestNeedTicketCommonWithUrl:@"/tenement-service/user/user.uploadReferencer.json" body_data:@{@"mobilePhone":_referenceTextField.text} success:^(NSString *path, NSDictionary *responseJson, NSDictionary *responseBody, NSInteger code) {
        
        NSLog(@"responseBody %@",responseBody);
        
        NSNumber *ret = [responseBody objectForKey:@"data"][@"result"];
        switch (ret.integerValue) {
            case 1:
            {
                [SVProgressHUD showImage:nil status:@"奖励积分领取成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [RootViewController presentViewControllerType:RootViewControllerTypeMainView];
                });
            }
                break;
            case 2:
            {
                [SVProgressHUD showImage:nil status:@"用户不存在"];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            }
                break;
            case 3:
            {
                 [SVProgressHUD showImage:nil status:@"推荐人不能是自己"];
                 [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            }
                break;
            default:
                break;
        }
        
    } fail:^(NSString *path, NSError *error) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_referenceTextField resignFirstResponder];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_referenceTextField resignFirstResponder];
}

@end
