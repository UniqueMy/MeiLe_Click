//
//  HTTPRequest.m
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import "HttpRequest.h"

#import "TEncryptorAES.h"
#import "TEncryptorRSA.h"

// 安全散列算法所需类
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>



@interface HttpRequest ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation HttpRequest

+ (instancetype)sharedInstance {
    
    static HttpRequest     *httpRequest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpRequest         = [[self alloc] init];
        httpRequest.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:HTTP_BASE_HOST]];
        httpRequest.manager.requestSerializer     = [AFJSONRequestSerializer  serializer];
        httpRequest.manager.responseSerializer    = [AFJSONResponseSerializer serializer];
        httpRequest.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    });
    return httpRequest;
}

/*
 *  初始化
 */
- (void)userInit {
    
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:HTTP_SESSION_ID];
    
    // 设置HEAD
    NSMutableDictionary *headParameters = [[NSMutableDictionary alloc] init];
    // 设置BODY-DATA
    NSMutableDictionary *dataParameters = [[NSMutableDictionary alloc] init];
    // 设置BODY
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    /*
     基础六项header
     */
    [headParameters setObject:HTTP_APP_VERSION forKey:@"version"];
    [headParameters setObject:HTTP_APP_ID forKey:@"appid"];
    [headParameters setObject:HTTP_APP_OS forKey:@"os"];
    [headParameters setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"appver"];
    [headParameters setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"uuid"];
    [headParameters setObject:([sessionId isKindOfClass:[NSString class]]&& sessionId.length)?sessionId:@"" forKey:@"sessionid"];
    
    
    [dataParameters setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"imei"];
    
    [bodyParameters setObject:dataParameters forKey:@"data"];
    
    NSDictionary *parameters = @{@"head":headParameters,@"body":[HttpRequest RSAencodeWithDictionary:bodyParameters]};
    
    [self.manager POST:@"/tenement-service/system/initsys.json" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDict = [HttpRequest RSAdecodeWithDictionary:responseObject];
        
        NSString *aesKey    = [[responseDict objectForKey:@"data"] objectForKey:@"aes"];
        NSString *sessionId = [[responseDict objectForKey:@"data"]objectForKey:@"sessionid"];
        NSString *ticket    = [[responseDict objectForKey:@"data"]objectForKey:@"ticket"];
        NSString *imghost   = [[responseDict objectForKey:@"data"]objectForKey:@"imghost"];
        NSString *frontUrl  = [[responseDict objectForKey:@"data"]objectForKey:@"frontUrl"];
        // 写入本地
        if ([aesKey isKindOfClass:[NSString class]] && aesKey.length) {
            [[NSUserDefaults standardUserDefaults] setObject:aesKey forKey:HTTP_AES_KEY];
            [[NSUserDefaults standardUserDefaults] setObject:sessionId forKey:HTTP_SESSION_ID];
        }
        if ([ticket isKindOfClass:[NSString class]] && ticket.length) {
            [[NSUserDefaults standardUserDefaults] setObject:ticket forKey:USER_ADMIN_TICKET_KEY];
        }
        if ([imghost isKindOfClass:[NSString class]] && imghost.length) {
            [[NSUserDefaults standardUserDefaults] setObject:imghost forKey:USER_ADMIN_IMGHOST_KEY];
        }
        if ([frontUrl isKindOfClass:[NSString class]] && frontUrl.length) {
            [[NSUserDefaults standardUserDefaults] setObject:frontUrl forKey:USER_ADMIN_FRONTURL_KEY];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSLog(@"Init -- responseObject --  %@  ",responseDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"----- ERROR ----- %@",error);
        [SVProgressHUD showInfoWithStatus:[[error.userInfo objectForKey:@"head"] objectForKey:@"rtnMsg"]];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }];
}

/**
 * 登录
 *
 * URL、responseObject、body、code
 */
- (void)userLogindictionary:(NSDictionary *)dictionary
                    success:(HttpRequestBlockType_Success)loginSuccess
                       fail:(HttpRequestBlockType_Failure)loginError {
    
    NSString *sessionId       = [[NSUserDefaults standardUserDefaults] objectForKey:HTTP_SESSION_ID];
    
    NSString *passwordString  = [HttpRequest secureHashAlgorithmWithNSString:dictionary[@"password"]];
    NSString *loginNameString = dictionary[@"loginName"];
    
    // 设置BODY-DATA
    NSMutableDictionary *dataParameters = [[NSMutableDictionary alloc] init];
    [dataParameters setObject:sessionId forKey:@"sessionid"];
    [dataParameters setObject:loginNameString forKey:@"loginName"];
    [dataParameters setObject:passwordString  forKey:@"password"];
    
    
    [self baseRequestWithUrl:@"/tenement-service/user/user.toLogin.json" body_data:dataParameters needTicket:HttpRequest_TicketType_NOT_TICKET success:^(NSString *path, NSDictionary *responseJson, id responseBody, NSInteger code) {
        
        loginSuccess(@"/tenement-service/user/user.toLogin.json",responseJson,responseBody,code);
        
    } fail:^(NSString *path, NSError *error) {
        
    }];
}

/**
 刷新票据
 
 @param successBlock URL、responseObject、body、code
 @param error error
 */
- (void)userRefrshTicketWithSuccess:(HttpRequestBlockType_Success)successBlock fail:(HttpRequestBlockType_Failure)error {
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:HTTP_SESSION_ID];
    // 设置HEAD
    NSMutableDictionary *headParameters = [[NSMutableDictionary alloc] init];
    // 设置BODY-DATA
    NSMutableDictionary *dataParameters = [[NSMutableDictionary alloc] init];
    // 设置BODY
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    /*
     基础六项header
     */
    [headParameters setObject:HTTP_APP_VERSION forKey:@"version"];
    [headParameters setObject:HTTP_APP_ID forKey:@"appid"];
    [headParameters setObject:HTTP_APP_OS forKey:@"os"];
    [headParameters setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"appver"];
    [headParameters setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"uuid"];
    [headParameters setObject:([sessionId isKindOfClass:[NSString class]]&& sessionId.length)?sessionId:@"" forKey:@"sessionid"];
    
    NSString *loginName = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ADMIN_LOGINNAME_KEY];
    NSString *password  = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ADMIN_PASSWORD_KEY];
    
    [dataParameters setObject:@"loginName" forKey:loginName];
    [dataParameters setObject:@"password"  forKey:password];
    [dataParameters setObject:@"type" forKey:@"1"];
    
    [bodyParameters setObject:dataParameters forKey:@"data"];
    
    NSString *ticket = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ADMIN_TICKET_KEY];
    [bodyParameters setObject:([ticket isKindOfClass:[NSString class]] && ticket.length)?ticket:@"" forKey:@"ticket"];
    
    NSDictionary *parameters = @{@"head":headParameters,
                                 @"body":[HttpRequest RSAencodeWithDictionary:bodyParameters]};
    
    [self.manager POST:@"/tenement-service/system/initsys.json" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSInteger code             = [self isSuccessFromResponseJsonObject:responseObject];
        NSDictionary *responseDict = [HttpRequest RSAdecodeWithDictionary:responseObject];
        
        NSMutableDictionary *bodyJson = [NSMutableDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]] ;
        bodyJson = [bodyJson dictionaryByRemovingNull];
        
        if (code == HttpRequest_ReCodeType_SUCCESS) {
            
            NSString *aesKey    = [[responseDict objectForKey:@"data"] objectForKey:@"aes"];
            NSString *sessionId = [[responseDict objectForKey:@"data"]objectForKey:@"sessionid"];
            NSString *ticket    = [[responseDict objectForKey:@"data"]objectForKey:@"ticket"];
            NSString *imghost   = [[responseDict objectForKey:@"data"]objectForKey:@"imghost"];
            NSString *frontUrl  = [[responseDict objectForKey:@"data"]objectForKey:@"frontUrl"];
            // 写入本地
            if ([aesKey isKindOfClass:[NSString class]] && aesKey.length) {
                [[NSUserDefaults standardUserDefaults] setObject:aesKey forKey:HTTP_AES_KEY];
                [[NSUserDefaults standardUserDefaults] setObject:sessionId forKey:HTTP_SESSION_ID];
            }
            if ([ticket isKindOfClass:[NSString class]] && ticket.length) {
                [[NSUserDefaults standardUserDefaults] setObject:ticket forKey:USER_ADMIN_TICKET_KEY];
            }
            if ([imghost isKindOfClass:[NSString class]] && imghost.length) {
                [[NSUserDefaults standardUserDefaults] setObject:imghost forKey:USER_ADMIN_IMGHOST_KEY];
            }
            if ([frontUrl isKindOfClass:[NSString class]] && frontUrl.length) {
                [[NSUserDefaults standardUserDefaults] setObject:frontUrl forKey:USER_ADMIN_FRONTURL_KEY];
            }
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            successBlock(@"/tenement-service/system/initsys.json",responseObject,bodyJson,code);
            
            NSLog(@"REFRSH --- ResponseObject --- %@",responseDict);
            
        } else {
            
            NSLog(@"----- Code == Other ----- ");
            [SVProgressHUD showInfoWithStatus:[[responseObject objectForKey:@"head"] objectForKey:@"rtnMsg"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"----- ERROR -----  %@",error);
        [SVProgressHUD showInfoWithStatus:[[error.userInfo objectForKey:@"head"] objectForKey:@"rtnMsg"]];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }];
    
}

/*
 *  公有都需要ticket的基础请求方法
 */

- (void)baseRequestNeedTicketCommonWithUrl:(NSString *)urlString
                                 body_data:(NSDictionary *)bodyData
                                   success:(HttpRequestBlockType_Success)successBlock
                                      fail:(HttpRequestBlockType_Failure)error {
    
    [self baseRequestWithUrl:urlString body_data:bodyData needTicket:HttpRequest_TicketType_NEED_TICKET success:^(NSString *path, NSDictionary *responseJson, id responseBody, NSInteger code) {
        
        
        NSMutableDictionary *bodyJson = [NSMutableDictionary dictionaryWithDictionary:[responseJson objectForKey:@"body"]] ;
        bodyJson = [bodyJson dictionaryByRemovingNull];
        
        successBlock(urlString,responseJson,bodyJson,code);
        
        
    } fail:^(NSString *path, NSError *error) {
        
    }];
}

- (void)baseRequestWithUrl:(NSString *)urlString
                 body_data:(NSDictionary *)bodyData
                needTicket:(BOOL)needTicket
                   success:(HttpRequestBlockType_Success)successBlock
                      fail:(HttpRequestBlockType_Failure)failBlock {
    
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:HTTP_SESSION_ID];
    
    // 设置HEAD
    NSMutableDictionary *headParameters = [[NSMutableDictionary alloc] init];
    // 设置BODY-DATA
    NSMutableDictionary *dataParameters = [[NSMutableDictionary alloc] init];
    // 设置BODY
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    
    /*
     * 基础六项header
     */
    [headParameters setObject:HTTP_APP_VERSION forKey:@"version"];
    [headParameters setObject:HTTP_APP_ID forKey:@"appid"];
    [headParameters setObject:HTTP_APP_OS forKey:@"os"];
    [headParameters setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"appver"];
    [headParameters setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"uuid"];
    [headParameters setObject:([sessionId isKindOfClass:[NSString class]]&& sessionId.length)?sessionId:@"" forKey:@"sessionid"];
    
    // 设置body层字典
    if ([bodyData isKindOfClass:[NSDictionary class]]) {
        
        [dataParameters addEntriesFromDictionary:bodyData];
        [bodyParameters setObject:dataParameters forKey:@"data"];
        
    } else if ([bodyData isKindOfClass:[NSString class]]) {
        
        [bodyParameters setObject:bodyData forKey:@"data"];// 275
    }
    
    // 设置TICKET
    if (needTicket) {
        NSString *ticket = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ADMIN_TICKET_KEY];
        [bodyParameters setObject:([ticket isKindOfClass:[NSString class]] && ticket.length)?ticket:@"" forKey:@"ticket"];
    }
    
    // 设置POST-BODY
    NSDictionary *retParameters =@{@"head":headParameters,@"body":[HttpRequest AESencodeWithDictionary:bodyParameters]};
    
    
    [self.manager POST:urlString parameters:retParameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            
            NSDictionary *responseJson = [HttpRequest AESdecodeWithDictionary:responseObject];
            
            NSLog(@"--- BASE ---  URL  %@ \r --- ResponseObject ---  %@ \r --- body --- %@ \r --- Message --- %@",urlString,responseObject,responseJson,[[responseObject objectForKey:@"head"] objectForKey:@"rtnMsg"]);
            
            NSInteger code = [self isSuccessFromResponseJsonObject:responseObject];
            
            
            
            if (code == HttpRequest_ReCodeType_SUCCESS) {
                
                if ([responseJson isKindOfClass:[NSDictionary class]]) {
                    
                    NSMutableDictionary *bodyJson = [NSMutableDictionary dictionaryWithDictionary:responseJson] ;
                    bodyJson = [bodyJson dictionaryByRemovingNull];
                    
                    successBlock(urlString,responseJson,bodyJson,code);
                    
                }
            } else if (code == HttpRequest_ReCodeType_OVERDUE) {
                
                NSLog(@"----- 票据过期，重新请求票据 ----- ");
                
                [[HttpRequest sharedInstance] userRefrshTicketWithSuccess:^(NSString *path, NSDictionary *responseJson, id responseBody, NSInteger code) {
                    
                    
                    
                    
                    [self baseRequestWithUrl:urlString body_data:bodyData needTicket:needTicket success:^(NSString *path, NSDictionary *responseJson, id responseBody, NSInteger code) {
                        
                        //                        if ([responseJson isKindOfClass:[NSDictionary class]]) {
                        //
                        //                            NSMutableDictionary *bodyJson = [NSMutableDictionary dictionaryWithDictionary:responseJson] ;
                        //                            bodyJson = [bodyJson dictionaryByRemovingNull];
                        //
                        //
                        //
                        successBlock(urlString,responseObject,responseBody,code);
                        
                        //                        }
                        
                    } fail:^(NSString *path, NSError *error) {}];
                    
                } fail:^(NSString *path, NSError *error) {}];
                
            } else {
                
                NSLog(@"----- 请求返回Other ----- ");
                [SVProgressHUD showInfoWithStatus:[[responseObject objectForKey:@"head"] objectForKey:@"rtnMsg"]];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failBlock(urlString,error);
        
    }];
}

- (HttpRequest_ReCodeType)isSuccessFromResponseJsonObject:(NSDictionary*)responseObject
{
    if ([NSJSONSerialization isValidJSONObject:responseObject]) {
        if ( [responseObject objectForKey:@"head"]) {
            
            NSString *rtnCode = [[responseObject objectForKey:@"head"] objectForKey:@"rtnCode"];
            
            if ([rtnCode isEqualToString:@"000000"]) {
                
                // 成功
                return HttpRequest_ReCodeType_SUCCESS;
                
            } else if ([rtnCode isEqualToString:@"900000"]||[rtnCode isEqualToString:@"900001"]||[rtnCode isEqualToString:@"900003"]) {
                
                // 票据过期
                return HttpRequest_ReCodeType_OVERDUE;
                
            } else {
                
                // 其他
                return HttpRequest_ReCodeType_OTHER;
            }
        }
    }
    return NO;
}

#pragma mark - 贝塞尔曲线切圆角

/**
 贝塞尔曲线画圆角
 
 @param view 圆角视图
 @param rect 范围
 @param corners 圆角方位
 @param radiiSize 大小
 */
+ (void)bezierPathWithView:(UIView *)view corners:(UIRectCorner)corners radii:(CGSize)radiiSize {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:radiiSize];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame         = view.bounds;
    maskLayer.path          = maskPath.CGPath;
    view.layer.mask         = maskLayer;
//    view.layer.masksToBounds = YES;
    
}

#pragma mark - 画虚线

/**
 画虚线
 
 @param lineView 变成虚线的view
 @param lineLength 单个虚线的长度
 @param lineSpacing 虚线间的间隔
 @param lineColor 虚线颜色
 */
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}



#pragma mark - 加密

// 安全散列算法
+ (NSString*)secureHashAlgorithmWithNSString:(NSString *)string {
    
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
        
    }
    return output;
}

// AES加密
+(NSString*)AESencodeWithDictionary:(NSMutableDictionary*)dict
{
    NSData *httpBodyContentData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:NULL];
    NSString *ecryptHttpBodyContentBase64String;
    NSString*aesKey = [[NSUserDefaults standardUserDefaults] objectForKey:HTTP_AES_KEY];
    if ([aesKey isKindOfClass:[NSString class]] && aesKey.length) {
        NSData *ecryptHttpBodyContentData = [TEncryptorAES AES128EncryptWithData:httpBodyContentData key:aesKey];
        ecryptHttpBodyContentBase64String  = [ecryptHttpBodyContentData base64EncodedStringWithOptions:0];
    }
    return ecryptHttpBodyContentBase64String;
}

// AES解密
+(NSMutableDictionary *)AESdecodeWithDictionary:(NSDictionary*)dict
{
    NSString *bodyString  = [dict objectForKey:@"body"];
    
    NSData *cipherData = [[NSData alloc]initWithBase64EncodedString:bodyString options:0];
    NSData *decryptBodyJsonData =  [TEncryptorAES AES128DecryptWithData:cipherData key:[[NSUserDefaults standardUserDefaults] objectForKey:HTTP_AES_KEY]];
    NSError *error ;
    NSMutableDictionary *bodydict = [NSJSONSerialization JSONObjectWithData:decryptBodyJsonData options:0 error:&error  ];
    return bodydict;
}

// RSA加密
+(NSString *)RSAencodeWithDictionary:(NSMutableDictionary*)dict
{
    NSData *httpBodyContentData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:NULL];
    NSData *ecryptHttpBodyContentData = [[TEncryptorRSA sharedEncryptor] encryptWithPublicKeyWithPlainData:httpBodyContentData];
    NSString *ecryptHttpBodyContentDataBase64String = [ecryptHttpBodyContentData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return ecryptHttpBodyContentDataBase64String;
}

// RSA解密
+(NSMutableDictionary *)RSAdecodeWithDictionary:(NSDictionary*)dict
{
    NSString *bodyString= [dict objectForKey:@"body"];
    NSData *cipherData = [[NSData alloc]initWithBase64EncodedString:bodyString options:0];
    NSData *decryptBodyJsonData =  [[TEncryptorRSA sharedEncryptor] decryptWithPublicKeyWithCipherData:cipherData];
    NSError *error ;
    NSMutableDictionary *bodydict = [NSJSONSerialization JSONObjectWithData:decryptBodyJsonData options:0 error:&error  ];
    return bodydict;
}


@end
