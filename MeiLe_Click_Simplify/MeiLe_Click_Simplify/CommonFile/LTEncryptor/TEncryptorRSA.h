//
//  TEncryptorRSA.h
//  Tenement_ios
//
//  Created by Futao on 15/7/1.
//  Copyright (c) 2015年 QQ:11386846. All rights reserved.
//
//  源码来自于 https://github.com/NianJi/BBRSACryptor
//

#import <Foundation/Foundation.h>


/**
 @abstract  padding type
 *  # define RSA_PKCS1_PADDING       1
 *  # define RSA_SSLV23_PADDING      2
 *  # define RSA_NO_PADDING          3
 **/
typedef NS_ENUM(NSInteger, T_RSA_PADDING_TYPE) {
    T_RSA_PADDING_TYPE_PKCS1      = 1,
    T_RSA_PADDING_TYPE_SSLV23     = 2,
    T_RSA_PADDING_TYPE_NONE       = 3,

};

typedef NS_ENUM(NSInteger, T_RSA_KEY_TYPE) {
    T_RSA_KEY_TYPE_Public      = 0,
    T_RSA_KEY_TYPE_Private     = 1,
    
};

@interface TEncryptorRSA : NSObject

+ (instancetype)sharedEncryptor;

///**
// @abstract  encrypt text using RSA public key
// @param     padding type add the plain text
// @return    encrypted data
// */
//- (NSData *)encryptWithPublicKeyUsingPadding:(T_RSA_PADDING_TYPE)padding
//                                   plainData:(NSData *)plainData;
//
///**
// @abstract  encrypt text using RSA private key
// @param     padding type add the plain text
// @return    encrypted data
// */
//- (NSData *)encryptWithPrivateKeyUsingPadding:(T_RSA_PADDING_TYPE)padding
//                                    plainData:(NSData *)plainData;
//
///**
// @abstract  decrypt text using RSA private key
// @param     padding type add the plain text
// @return    encrypted data
// */
//- (NSData *)decryptWithPrivateKeyUsingPadding:(T_RSA_PADDING_TYPE)padding
//                                   cipherData:(NSData *)cipherData;
//
///**
// @abstract  decrypt text using RSA public key
// @param     padding type add the plain text
// @return    encrypted data
// */
//- (NSData *)decryptWithPublicKeyUsingPadding:(T_RSA_PADDING_TYPE)padding
//                                  cipherData:(NSData *)cipherData;

/**
 @abstract  encrypt text using RSA private key T_RSA_PADDING_TYPE_PKCS1
 @param     plainData type add the plain text
 @return    encrypted data
 */
- (NSData *)encryptWithPrivateKeyWithPlainData:(NSData *)plainData;

/**
 @abstract  encrypt text using RSA public key T_RSA_PADDING_TYPE_PKCS1
 @param     plainData type add the plain text
 @return    encrypted data
 */
- (NSData *)encryptWithPublicKeyWithPlainData:(NSData *)plainData;

/**
 @abstract  decrypt text using RSA private key T_RSA_PADDING_TYPE_PKCS1
 @param     cipherData type add the plain text
 @return    encrypted data
 */
- (NSData *)decryptWithPrivateKeyWithCipherData:(NSData *)cipherData;

/**
 @abstract  decrypt text using RSA public key T_RSA_PADDING_TYPE_PKCS1
 @param     cipherData type add the plain text
 @return    encrypted data
 */
- (NSData *)decryptWithPublicKeyWithCipherData:(NSData *)cipherData;
@end
