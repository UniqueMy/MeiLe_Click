//
//  UserModel.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <YYModel/YYModel.h>

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *idcard;
/** 手机号*/
@property (nonatomic, strong) NSString *mobilePhone;
/** 用户等级：0-普通用户，1-实名审核中，2-实名认证用户，9-管理用户*/
@property (nonatomic, strong) NSString *level;
/** 电子邮件*/
@property (nonatomic, strong) NSString *email;
/** 状态：0-停用，1-启用*/
@property (nonatomic, strong) NSString *status;
///** 登录名*/
// @property (nonatomic,strong) NSString *loginName;
/** 生活圈编号*/
@property (nonatomic, strong) NSString *lifecircleId;
/** 生活圈名称*/
@property (nonatomic, strong) NSString *lifecircleName;
/** 小区ID*/
@property (nonatomic, strong) NSString *regionalId;
/** 小区名称*/
@property (nonatomic, strong) NSString *regionalName;
/** 用户名称（昵称）*/
@property (nonatomic, strong) NSString *nickerName;
/** 性别*/
@property (nonatomic, strong) NSString *sex;
/** 生日*/
@property (nonatomic, strong) NSString *birthday;
/** 证件类型：0-身份证，1-军官证，2-护照*/
@property (nonatomic, strong) NSString *certType;
/** 头像*/
@property (nonatomic, strong) NSString *headphoto;
/** 座机*/
@property (nonatomic, strong) NSString *telephone;
/** 职位*/
@property (nonatomic, strong) NSString *jobTitle;
/** 爱好*/
@property (nonatomic, strong) NSString *habit;
/** 特长*/
@property (nonatomic, strong) NSString *speciality;
/** 签名*/
@property (nonatomic, strong) NSString *sign;
/** 用户编号*/
@property (nonatomic, strong) NSString *userId;
/** 真实姓名*/
@property (nonatomic, strong) NSString *realName;
/** 实名制审核日期*/
@property (nonatomic, strong) NSString *checkRealnameDate;
/** 申请实名制日期*/
@property (nonatomic, strong) NSString *applyRealnameDate;
/** 身份证照片*/
@property (nonatomic, strong) NSString *idcardPhoto;
/** 审核状态0-审核中，1-审核不通过，2-审核通过*/
@property (nonatomic, strong) NSString *realnameStatus;
/** 审核备注*/
@property (nonatomic, strong) NSString *realnameRemark;

@property (nonatomic ,copy)   NSString *dept;//住址id

@property (nonatomic,copy)    NSString *name ;//真实姓名

@property (nonatomic,copy)    NSString *deptName ;//住址小区名称

@property (nonatomic,copy)    NSString *door ;//门牌号

@property(nonatomic,assign)   CGFloat   latitude;//家庭住址的经纬度
@property(nonatomic,assign)   CGFloat  longitude;


/**
 *  <#Description#>
 */
@property (nonatomic, strong) NSString  *xbbTaobaoName;
@property (nonatomic, strong) NSString  *xbbTaobaoPass;
@property (nonatomic, strong) NSString  *ddxTaobaoName;
@property (nonatomic, strong) NSString  *ddxTaobaoPass;
//
@property (nonatomic, strong) NSString *isHelpMan;

@end
