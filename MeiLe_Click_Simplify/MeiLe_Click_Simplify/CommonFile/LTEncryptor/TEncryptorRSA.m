//
//  TEncryptorRSA.m
//  Tenement_ios
//
//  Created by Futao on 15/7/1.
//  Copyright (c) 2015年 QQ:11386846. All rights reserved.
//

#import "TEncryptorRSA.h"

#import "rsa.h"
#import "pem.h"

#define T_RSA_MAX_ENCRYPT_BLOCK 117
#define T_RSA_MAX_DECRYPT_BLOCK 128


@interface TEncryptorRSA ()
{
    RSA *_rsaPublic;
    RSA *_rsaPrivate;
}

@end

@implementation TEncryptorRSA

+ (instancetype)sharedEncryptor {
    static TEncryptorRSA *__shared = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shared = [[self alloc] init];
    });
    
    return __shared;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        FILE *publicKeyFile;
        const char *publicKeyFileName = [[[NSBundle mainBundle] pathForResource:@"rsa_public_key" ofType:@"pem"] cStringUsingEncoding:NSUTF8StringEncoding];
        publicKeyFile = fopen(publicKeyFileName,"rb");
        if (NULL != publicKeyFile)
        {
            BIO *bpubkey = NULL;
            bpubkey = BIO_new(BIO_s_file());
            BIO_read_filename(bpubkey, publicKeyFileName);
            
            _rsaPublic = PEM_read_bio_RSA_PUBKEY(bpubkey, NULL, NULL, NULL);
            BIO_free_all(bpubkey);
            fclose(publicKeyFile);
        }else{
            printf( "Failed to open rsa_public_key.pem File");

        }

        FILE *privateKeyFile;
        const char *privateKeyFileName = [[[NSBundle mainBundle] pathForResource:@"rsa_private_key" ofType:@"pem"] cStringUsingEncoding:NSUTF8StringEncoding];
        privateKeyFile = fopen(privateKeyFileName,"rb");
        if (NULL != privateKeyFile)
        {
            BIO *bpubkey = NULL;
            bpubkey = BIO_new(BIO_s_file());
            BIO_read_filename(bpubkey, privateKeyFileName);
            _rsaPrivate = PEM_read_bio_RSAPrivateKey(bpubkey, NULL, NULL, NULL);
            BIO_free_all(bpubkey);
            fclose(publicKeyFile);

        }else{
            printf( "Failed to open rsa_private_key.pem File");

        }
        
        
    }
    return self;
}


//
//- (NSData *)encryptWithPrivateKeyUsingPadding:(T_RSA_PADDING_TYPE)padding plainData:(NSData *)plainData
//{
//    return [self encryptRSAKeyWithType:T_RSA_KEY_TYPE_Private paddingType:padding data:plainData];
//
//}
//- (NSData *)encryptWithPublicKeyUsingPadding:(T_RSA_PADDING_TYPE)padding plainData:(NSData *)plainData
//{
//    return [self encryptRSAKeyWithType:T_RSA_KEY_TYPE_Public paddingType:padding data:plainData];
//    
//}
//
//- (NSData *)decryptWithPrivateKeyUsingPadding:(T_RSA_PADDING_TYPE)padding cipherData:(NSData *)cipherData
//{
//    return [self decryptRSAKeyWithType:T_RSA_KEY_TYPE_Private paddingType:padding encryptedData:cipherData];
//
//}
//
//- (NSData *)decryptWithPublicKeyUsingPadding:(T_RSA_PADDING_TYPE)padding cipherData:(NSData *)cipherData
//{
//    return [self decryptRSAKeyWithType:T_RSA_KEY_TYPE_Public paddingType:padding encryptedData:cipherData];
//}

- (NSData *)encryptWithPrivateKeyWithPlainData:(NSData *)plainData
{
    return [self encryptRSAKeyWithType:T_RSA_KEY_TYPE_Private paddingType:T_RSA_PADDING_TYPE_PKCS1 data:plainData];
    
}

- (NSData *)encryptWithPublicKeyWithPlainData:(NSData *)plainData
{
    return [self encryptRSAKeyWithType:T_RSA_KEY_TYPE_Public paddingType:T_RSA_PADDING_TYPE_PKCS1 data:plainData];
}


- (NSData *)decryptWithPrivateKeyWithCipherData:(NSData *)cipherData
{
    return [self decryptRSAKeyWithType:T_RSA_KEY_TYPE_Private paddingType:T_RSA_PADDING_TYPE_PKCS1 encryptedData:cipherData];
}

- (NSData *)decryptWithPublicKeyWithCipherData:(NSData *)cipherData
{
    return [self decryptRSAKeyWithType:T_RSA_KEY_TYPE_Public paddingType:T_RSA_PADDING_TYPE_PKCS1 encryptedData:cipherData];

}




- (NSData *)encryptRSAKeyWithType:(T_RSA_KEY_TYPE)keyType paddingType:(T_RSA_PADDING_TYPE)padding data:(NSData *)data {
    if (data && [data length]) {
        NSMutableData *encryptedData = [NSMutableData dataWithCapacity:0];
        int flen_total = (int)[data length];
        while (flen_total) {
            int flen = T_RSA_MAX_ENCRYPT_BLOCK;
            if (flen_total <= flen) {
                flen = flen_total;
            }
            unsigned char from[flen];
            bzero(from, sizeof(from));
            memcpy(from, [[data subdataWithRange:NSMakeRange([data length] - flen_total, flen)] bytes], flen);
            unsigned char to[128];
            bzero(to, sizeof(to));
            int len = [self encryptRSAKeyWithType:keyType :from :flen :to :padding];
            if (len > 0) {
                [encryptedData appendBytes:to length:len];
            }
            flen_total -= flen;
        }
        return encryptedData;
    }
    return nil;
}

- (NSData *)decryptRSAKeyWithType:(T_RSA_KEY_TYPE)keyType paddingType:(T_RSA_PADDING_TYPE)padding encryptedData:(NSData *)data {
    if (data && [data length]) {
        NSMutableData *decryptedData = [NSMutableData dataWithCapacity:0];
        int flen_total = (int)[data length];
        while (flen_total) {
            int flen = T_RSA_MAX_DECRYPT_BLOCK;
            if (flen_total <= flen) {
                flen = flen_total;
            }
            unsigned char from[flen];
            bzero(from, sizeof(from));
            memcpy(from, [[data subdataWithRange:NSMakeRange([data length] - flen_total, flen)] bytes], flen);
            unsigned char to[128];
            bzero(to, sizeof(to));
            int len = [self decryptRSAKeyWithType:keyType :from :flen :to :padding];
            if (len > 0) {
                [decryptedData appendBytes:to length:len];
            }
            flen_total -= flen;
        }
        return decryptedData;
    }
    return nil;
}

#pragma mark - Base

- (int)encryptRSAKeyWithType:(T_RSA_KEY_TYPE)keyType :(const unsigned char *)from :(int)flen :(unsigned char *)to :(T_RSA_PADDING_TYPE)padding {
    if (from != NULL && to != NULL) {
        int status =  -1;
        switch (keyType) {
            case T_RSA_KEY_TYPE_Private: {
                //start encrypt
                status =  RSA_private_encrypt(flen, from,to, _rsaPrivate,  padding);
            }
                break;
            default:{
                //start encrypt
                status =  RSA_public_encrypt(flen,from,to, _rsaPublic,  padding);
            }
                break;
        }
        return status;
    }
    return -1;
}

- (int)decryptRSAKeyWithType:(T_RSA_KEY_TYPE)keyType :(const unsigned char *)from :(int)flen :(unsigned char *)to :(T_RSA_PADDING_TYPE)padding {
    if (from != NULL && to != NULL) {
        int status =  -1;
        switch (T_RSA_KEY_TYPE_Private) {
            case 0:{	
                //start encrypt
                status =  RSA_private_decrypt(flen, from, to, _rsaPrivate,  padding);
            }
                break;
            default:{
                //start encrypt
                status =  RSA_public_decrypt(flen, from, to, _rsaPublic,  padding);
            }
                break;
        }
        return status;
    }
    return -1;
}

- (void)dealloc {
    RSA_free(_rsaPrivate);
    RSA_free(_rsaPublic);

}
@end
