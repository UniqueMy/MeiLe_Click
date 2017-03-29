//
//  PersonBaseInfoViewController.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/3/6.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "PersonBaseInfoViewController.h"
#import "SHDatePickerView.h"
#import "AppDelegate.h"
#import "PersonNicknameViewController.h"
#import "PersonSignatureViewController.h"
#import "PersonFamilyAddressViewController.h"

@interface PersonBaseInfoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SHDatePickerViewDelegate,PersonNicknameDelegate,PersonSignatureDelegate>

@property (nonatomic,strong) SHDatePickerView *dateView;
@property (nonatomic,strong) UIView           *backgroundView;
@property (nonatomic,strong) AppDelegate      *appdelegate;

@end

@implementation PersonBaseInfoViewController

- (UIView *)backgroundView {
    
    if (!_backgroundView) {
        
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor clearColor];
    }
    return _backgroundView;//667382613714
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人信息";
    [HttpRequest bezierPathToLayerRadiusWithView:_headImageView];
    
    _appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
}

- (IBAction)setHeadImage:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择采集信息的方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"本地相册", nil];
    actionSheet.tag = ActionSheet_Photo;
    [actionSheet showInView:self.view];
    
}

- (IBAction)setNickName:(id)sender {
    
    PersonNicknameViewController *nicknameVC = [[PersonNicknameViewController alloc] init];
    nicknameVC.delegate                      = self;
    nicknameVC.textString                    = _nicknameLabel.text;
    
    [self.navigationController pushViewController:nicknameVC animated:YES];
}

- (void)saveNicknameWithString:(NSString *)string {
    
    _nicknameLabel.text = string;
}


- (IBAction)setBirthday:(id)sender {
    
    
    UITapGestureRecognizer *tapLeftDouble  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage:)];
    [_appdelegate.window addGestureRecognizer:tapLeftDouble];
    
    [_appdelegate.window addSubview:self.backgroundView];
    
    [UIView animateWithDuration:.15f animations:^{
        self.backgroundView.backgroundColor = RGB(0, 0, 0);
        self.backgroundView.alpha = .4f;
    }];
    
    CATransition *animation = [CATransition animation];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setDuration:.15f];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype: kCATransitionFromTop];
    
    _dateView          = [SHDatePickerView viewFromXIB];
    _dateView.delegate = self;
    _dateView.frame    = CGRectMake(0, viewHeight - 261, viewWidth, 261);
    [_appdelegate.window addSubview:_dateView];
    
    [_dateView.layer addAnimation:animation forKey:@"Reveal"];
    
}

- (void)removeDatePicker {
    
    [_dateView removeFromSuperview];
    [self.backgroundView removeFromSuperview];
}

- (void)submitDate:(NSString *)dateString {
    
    _birthdayLabel.text = dateString;
    [self removeDatePicker];
}


- (IBAction)setSex:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请问您是先生还是女士?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    actionSheet.tag = ActionSheet_Sex;
    [actionSheet showInView:self.view];
    
}

- (IBAction)setSignature:(id)sender {
    
    PersonSignatureViewController *signatureVC = [[PersonSignatureViewController alloc] init];
    signatureVC.signatureString = _signatureLabel.text;
    signatureVC.delegate        = self;
    [self.navigationController pushViewController:signatureVC animated:YES];
}

- (void)saveSignatureWithString:(NSString *)string {
    
    _signatureLabel.text = string;
}

- (IBAction)setAddress:(id)sender {
    
    PersonFamilyAddressViewController *addressVC = [[PersonFamilyAddressViewController alloc] init];
    [self.navigationController pushViewController:addressVC animated:YES];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            if (actionSheet.tag == ActionSheet_Photo) {
                
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    [alertController addAction:cancelAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                    return;
                }
                
                [self getHeadImageFromUIImagePickerControllerSourceType:UIImagePickerControllerSourceTypeCamera];
                
            } else if (actionSheet.tag == ActionSheet_Sex) {
                
               _sexLabel.text = @"男";
            }
        }
            break;
        case 1:
        {
            if (actionSheet.tag == ActionSheet_Photo) {
                
                [self getHeadImageFromUIImagePickerControllerSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                
            } else if (actionSheet.tag == ActionSheet_Sex) {
                
                 _sexLabel.text = @"女";
            }
        }
            break;
        case 2:
            NSLog(@"取消");
            break;
            
        default:
            break;
    }
}

- (void)getHeadImageFromUIImagePickerControllerSourceType:(int)type {
    
    UIImagePickerController *pickController = [[UIImagePickerController alloc] init];
    pickController.sourceType = type;
    pickController.delegate   = self;
    [self presentViewController:pickController animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    _headImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)magnifyImage:(UIGestureRecognizer *)gesture
{
        [_dateView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
}

@end
