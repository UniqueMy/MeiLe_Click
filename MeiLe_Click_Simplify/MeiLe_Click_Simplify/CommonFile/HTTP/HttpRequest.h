//
//  HTTPRequest.h
//  MeiLe_Click_Simplify
//
//  Created by 盛浩 on 2017/2/16.
//  Copyright © 2017年 ShengHao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,HttpRequest_TicketType) {
    
    HttpRequest_TicketType_NEED_TICKET,
    HttpRequest_TicketType_NOT_TICKET,
    
};

typedef NS_ENUM(NSUInteger,HttpRequest_ReCodeType) {
    
    HttpRequest_ReCodeType_SUCCESS,
    HttpRequest_ReCodeType_OVERDUE,
    HttpRequest_ReCodeType_OTHER,
    
};



typedef void(^HttpRequestBlockType_Success)(NSString *path,NSDictionary *responseJson,NSDictionary *responseBody,NSInteger code);
typedef void(^HttpRequestBlockType_Failure)(NSString *path,NSError *error);


@interface HttpRequest : NSObject


/**
  * 单例
  */
+ (instancetype)sharedInstance;

/*
 *  初始化
 */
- (void)userInit;

/*
 *  登录
 */
- (void)userLogindictionary:(NSDictionary *)dictionary
                    success:(HttpRequestBlockType_Success)successBlock
                       fail:(HttpRequestBlockType_Failure)error;

/*
 *  刷新票据
 */
- (void)userRefrshTicketWithSuccess:(HttpRequestBlockType_Success)successBlock
                               fail:(HttpRequestBlockType_Failure)error;


/*
 *  公有都需要ticket的基础请求方法
 */
- (void)baseRequestNeedTicketCommonWithUrl:(NSString *)urlString
                                 body_data:(NSDictionary *)bodyData
                                   success:(HttpRequestBlockType_Success)successBlock
                                      fail:(HttpRequestBlockType_Failure)error;



/**
 贝塞尔曲线画圆角

 @param view 圆角视图
 @param rect 范围
 @param corners 圆角方位
 @param radiiSize 大小
 */
+ (void)bezierPathWithView:(UIView *)view corners:(UIRectCorner)corners radii:(CGSize)radiiSize;

/**
 画虚线
 
 @param lineView 变成虚线的view
 @param lineLength 单个虚线的长度
 @param lineSpacing 虚线间的间隔
 @param lineColor 虚线颜色
 */
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

/**
 安全散列算法
 
 @param string 传入NSDictionary
 @return 返回NSString
 */
+ (NSString*)secureHashAlgorithmWithNSString:(NSString *)string;

/**
 AES加密
 
 @param dict 传入NSDictionary
 @return 返回NSString
 */
+(NSString*)AESencodeWithDictionary:(NSMutableDictionary*)dict;


/**
 AES解密
 
 @param dict 传入NSDictionary
 @return 返回NSMutableDictionary
 */
+(NSMutableDictionary *)AESdecodeWithDictionary:(NSDictionary*)dict;


/**
 RSA加密
 
 @param dict 传入NSDictionary
 @return  返回NSString
 */
+(NSString *)RSAencodeWithDictionary:(NSMutableDictionary*)dict;


/**
 RSA解密
 
 @param dict 传入NSDictionary
 @return  返回NSMutableDictionary
 */
+(NSMutableDictionary *)RSAdecodeWithDictionary:(NSDictionary*)dict;




@end
