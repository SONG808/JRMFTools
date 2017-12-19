//
//  JYangLib.m
//  JYangToolKit
//
//  Created by 一路财富 on 16/10/11.
//  Copyright © 2016年 JYang. All rights reserved.
//
//
/*
 11-22 更改了UIController+Waiting文件。
 12-14 Tools添加发放：1.去除首尾空格
 12-15 Https请求网络异常显示处理
 12-19 网络请求，针对服务器异常处理
 */

#import "JYangLib.h"
#import <CommonCrypto/CommonCryptor.h>

#import "UIImageView+JYWebCache.h"
#import "UIViewController+Waiting.h"

#import "JYangKeyChain.h"
#import "JYangStatiTool.h"

#import "JYSecurityPolicy.h"

#define kIsEmpty(_ref)      (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

#define certificate     @"jrmf"
#define cerNotFind      @"credentialNotFind"

//定义一个变量
static JYangLib *helper = nil;

@interface JYangLib () <NSURLSessionDelegate>

@end

@implementation JYangLib

//实例化对象
+ (instancetype)shareHelper {
    @synchronized(self) {
        if (!helper) {
            helper = [[JYangLib alloc] init];
        }
        return helper;
    }
}

#pragma mark - Set ImageView
+ (void)JYangLibsetImageWithImageView:(UIImageView *)imageView URL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    
    if ([url.absoluteString hasPrefix:@"https://"]) {
        [imageView jy_setImageWithURL:url placeholderImage:placeholder options:JYWebImageAllowInvalidSSLCertificates];
    }else {
        [imageView jy_setImageWithURL:url placeholderImage:placeholder options:JYWebImageRefreshCached];
    }
}

#pragma mark - Show Hint
+ (void)JYangLibShowWaitInViewController:(UIViewController *)viewController hint:(NSString *)hint {
    [viewController showWaitInView:viewController.view hint:hint];
}

+ (void)JYangLibHideWaitWithViewController:(UIViewController *)viewController {
    [viewController hideWait];
}

+ (void)JYangLibShowWait:(NSString *)hint InViewController:(UIViewController *)viewController {
    [viewController showWait:hint];
}

+ (void)JYangLibShowWait:(NSString *)hint InViewController:(UIViewController *)viewController completion:(completedBlock)completion{
    [viewController showWait:hint completion:completion];
}

#pragma mark - 网络请求
/**
 普通post方法请求网络数据
 
 @param reqUrl  请求网址路径
 @param param   请求参数
 @param success 成功回调
 @param fail    失败回调
 */

+ (NSURLSessionDataTask *)httpPostGetRequestWithLink:(NSString *)reqUrl parameter:(NSString *)param Success:(JYResponseSuccess)success Fail:(JYResponseFail)fail {
    // 设置URL
    NSURL * url = [NSURL URLWithString:reqUrl];
    // 创建请求
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    // 设置为POST请求
    [request setHTTPMethod:@"POST"];
    
    // 设置参数
    NSData * data = [param dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    // 构造Session
    NSURLSession * session = [NSURLSession sharedSession];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLSessionDataTask *task;
    task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if (error) {
                if (error.code == NSURLErrorCancelled) {
                    return ;
                }
                fail(task, error);
                return ;
            }
            
            NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            if (kIsEmpty(content)) {
//                NSError *err = [[NSError alloc] initWithDomain:@"服务器异常,请重试" code:-0011 userInfo:nil];
//                fail(task, err);
//                return;
//            }
            success(task, content);
        });
    }];
    
    [task resume];
    return task;
}

//post请求
+ (NSURLSessionDataTask *)postGetRequestWithLink:(NSString *)reqUrl parameter:(NSString *)param Success:(JYResponseSuccess)success Fail:(JYResponseFail)fail {
    @autoreleasepool {
        
        if ([reqUrl hasPrefix:@"http:"]) {
            return [JYangLib httpPostGetRequestWithLink:reqUrl parameter:param Success:success Fail:fail];
        }
        
        [self shareHelper];
        NSURL *nsurl = [NSURL URLWithString:reqUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
        request.timeoutInterval = 30.f;
        //设置请求方式
        request.HTTPMethod = @"POST";
        //设置请求体
        request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        __block NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:helper delegateQueue:queue];
        NSURLSessionDataTask *dataTask;
        dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                if (error.code == NSURLErrorCancelled) {
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:cerNotFind]) {
                        NSMutableDictionary * errorDic = [[NSMutableDictionary alloc] initWithDictionary:error.userInfo];
                        [errorDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                            if ([key isEqual:NSLocalizedDescriptionKey]) {
                                [errorDic removeObjectForKey:key];
                                [errorDic setObject:NSLocalizedStringFromTable(@"https公钥未找到", @"JrmfInfo", nil) forKey:key];
                            }
                        }];
                        NSError *err = [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:errorDic];
                        fail(dataTask, err);
                    }
                    [session invalidateAndCancel];
                    session = nil;
                    return ;
                }
                
                if (error.code == NSURLErrorNotConnectedToInternet) {
                    NSMutableDictionary * errorDic = [[NSMutableDictionary alloc] initWithDictionary:error.userInfo];
                    [errorDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        if ([key isEqual:NSLocalizedDescriptionKey]) {
                            [errorDic removeObjectForKey:key];
                            [errorDic setObject:NSLocalizedStringFromTable(@"网络异常,请检查网络", @"JrmfInfo", nil) forKey:key];
                        }
                    }];
                    NSError *err = [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:errorDic];
                    fail(dataTask, err);
                    [session invalidateAndCancel];
                    session = nil;
                    return;
                }
                fail(dataTask, error);
                [session invalidateAndCancel];
                session = nil;
                return ;
            }
            
            NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (kIsEmpty(content)) {
                NSMutableDictionary * errorDic = [[NSMutableDictionary alloc] init];
                [errorDic setValue:NSLocalizedStringFromTable(@"服务器异常,请重试", @"JrmfInfo", nil) forKey:NSLocalizedDescriptionKey];
                [errorDic setValue:dataTask.response.URL forKey:NSURLErrorFailingURLErrorKey];
                NSError *err = [[NSError alloc] initWithDomain:NSURLErrorDomain code:NSURLErrorUnknown userInfo:errorDic];
                fail(dataTask, err);
                [session invalidateAndCancel];
                session = nil;
                return;
            }
            success(dataTask, content);
            [session invalidateAndCancel];
            session = nil;
            
        }];
        [dataTask resume];
        return dataTask;
    }
}

//主要就是处理HTTPS请求的
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengeUseCredential;
    __block NSURLCredential *credential = nil;
    
    // 先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"];//证书的路径
    
    if (cerPath==nil) {
        NSLog(@"---Jrmf---error:客户端公钥未查找到，网络请求无法继续---");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:cerNotFind];
        if (completionHandler) {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, credential);
        }
        return;
    }
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:cerNotFind];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    JYSecurityPolicy *securityPolicy = [JYSecurityPolicy policyWithPinningMode:JYSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = NO;
    
    securityPolicy.validatesDomainName = YES;
    
    securityPolicy.pinnedCertificates = @[certData];
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
            credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
        } else {
            [[challenge sender] cancelAuthenticationChallenge:challenge];
        }
    } else {
        if ([challenge previousFailureCount] == 0) {
            if (credential) {
                [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
            } else {
                [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
            }
        } else {
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
        }
    }
    
    //安装证书
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}

#pragma mark - 数据统计
+ (NSString *)GetJYangToolLibMsg {
    //* 设置参数
    NSString * uuid = [JYangKeyChain JYangKeyChainLoad];
    if (kIsEmpty(uuid)) {
        //生成一个uuid的方法
        CFUUIDRef uuidRef= CFUUIDCreate(kCFAllocatorDefault);
        uuid = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef));
        CFRelease(uuidRef);
        //将该uuid保存到keychain
        [JYangKeyChain JYangKeyChainSave:uuid];
    }
    
    NSString * param = [NSString stringWithFormat:@"deviceuuid=%@&sysVersion=%@&deviceType=%@&deviceIMEI=%@&appName=%@&location=%@", uuid, [JYangStatiTool getSystemVersion], [JYangStatiTool getDeviceType], @"", [JYangStatiTool getAppName], @""];
    
    NSString * dataStr = [JYangLib encrypt:param withKey:@"JrmfJYangTool"];
    return dataStr;
}

// 加密方法
+ (NSString*)encrypt:(NSString*)baseStr withKey:(NSString *)key {
    //*加密1.字符串转data
    NSData * baseData = [baseStr dataUsingEncoding:NSUTF8StringEncoding];
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [baseData length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus;
    cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                          keyPtr, kCCBlockSizeDES,
                          NULL,
                          [baseData bytes], dataLength,
                          buffer, bufferSize,
                          &numBytesEncrypted);
    
    NSData * data = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    
    //*加密2.data转byte
    Byte *jmbytes = (Byte *)[data bytes];
    
    
    //*加密3.下面是Byte 转换为16进制。
    NSString *hexString = @"";
    for(int i=0;i<[data length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%X",jmbytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexString = [NSString stringWithFormat:@"%@0%@",hexString,newHexStr];
        else
            hexString = [NSString stringWithFormat:@"%@%@",hexString,newHexStr];
    }
    
    return hexString;
}


@end
