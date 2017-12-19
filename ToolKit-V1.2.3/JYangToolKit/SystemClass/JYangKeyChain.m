//
//  JYangKeyChain.m
//  JrmfPacketKit
//
//  Created by 一路财富 on 16/10/26.
//  Copyright © 2016年 JYang. All rights reserved.
//

#import "JYangKeyChain.h"
#import <Security/Security.h>

#define KEY_PASSWORD  @"com.jrmf.app.password"
#define KEY_USERNAME_PASSWORD  @"com.jrmf.app.usernamepassword"

@implementation JYangKeyChain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
//            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

#pragma mark - KeyChain 方法
+ (void)JYangKeyChainSave:(NSString *)service {
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:service forKey:KEY_PASSWORD];
    [JYangKeyChain save:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];
}

+ (NSString *)JYangKeyChainLoad {
    NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[JYangKeyChain load:KEY_USERNAME_PASSWORD];
    
//    NSLog(@"%@",[usernamepasswordKVPairs objectForKey:KEY_PASSWORD]);

    return [usernamepasswordKVPairs objectForKey:KEY_PASSWORD];
}

+ (void)JYangKeyChainDelete:(NSString *)service {
    [JYangKeyChain delete:KEY_USERNAME_PASSWORD];
}

@end
