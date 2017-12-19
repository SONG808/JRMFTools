//
//  JYSecurityPolicy.h
//  httpsDemo
//
//  Created by 一路财富 on 16/12/6.
//  Copyright © 2016年 JYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

typedef NS_ENUM(NSUInteger, JYSSLPinningMode) {
    JYSSLPinningModeNone,
    JYSSLPinningModePublicKey,
    JYSSLPinningModeCertificate,
};

/*
 `AFSSLPinningModeNone` 不适使用证书去验证服务器
 Do not used pinned certificates to validate servers.
 
 `AFSSLPinningModePublicKey` 对固定证书公钥的公钥证书进行验证。
 Validate host certificates against public keys of pinned certificates.
 
 `AFSSLPinningModeCertificate` 验证对固定证书的主机证书
 Validate host certificates against pinned certificates.
 */

NS_ASSUME_NONNULL_BEGIN

@interface JYSecurityPolicy : NSObject <NSSecureCoding, NSCopying>

/**
 服务器信任的证书应该是一个标准的SSL证书. Defaults  `AFSSLPinningModeNone`.
 The criteria by which server trust should be evaluated against the pinned SSL certificates.
 */
@property (readonly, nonatomic, assign) JYSSLPinningMode SSLPinningMode;

/**
 证书用来 根据SSL的mode来判断 服务器是否可信，这个位置可以设置bundle中的任何cer文件。
 The certificates used to evaluate server trust according to the SSL pinning mode. By default, this property is set to any (`.cer`) certificates included in the app bundle. Note that if you create an array with duplicate certificates, the duplicate certificates will be removed. Note that if pinning is enabled, `evaluateServerTrust:forDomain:` will return true if any pinned certificate matches.
 */
@property (nonatomic, strong, nullable) NSArray *pinnedCertificates;

/**
 无论如何，信任服务器失效或者过期的SSL证书。Defaults to `NO`.
 Whether or not to trust servers with an invalid or expired SSL certificates.
 */
@property (nonatomic, assign) BOOL allowInvalidCertificates;

/**
 无论如何，不验证CN文件中的域名。 Defaults to `YES`.
 Whether or not to validate the domain name in the certificate's CN field.
 */
@property (nonatomic, assign) BOOL validatesDomainName;

///-----------------------------------------
/// @name Getting Specific Security Policies 获得一个特别的
///-----------------------------------------

/**
 返回默认值，Mode=None,信任任何证书，不验证域名
 Returns the shared default security policy, which does not allow invalid certificates, validates domain name, and does not validate against pinned certificates or public keys.
 
 @return The default security policy.
 */
+ (instancetype)defaultPolicy;

///---------------------
/// @name Initialization 初始化
///---------------------

/**
 Creates and returns a security policy with the specified pinning mode.
 
 @param pinningMode The SSL pinning mode.
 
 @return A new security policy.
 */
+ (instancetype)policyWithPinningMode:(JYSSLPinningMode)pinningMode;

///------------------------------
/// @name Evaluating Server Trust 判断服务器是否可信
///------------------------------

/**
 Whether or not the specified server trust should be accepted, based on the security policy.
 
 This method should be used when responding to an authentication challenge from a server.
 
 @param serverTrust The X.509 certificate trust of the server.
 @param domain The domain of serverTrust. If `nil`, the domain will not be validated.
 
 @return Whether or not to trust the server.
 */
- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:(nullable NSString *)domain;

@end

NS_ASSUME_NONNULL_END
