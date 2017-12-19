//
//  JYangKeyChain.h
//  JrmfPacketKit
//
//  Created by 一路财富 on 16/10/26.
//  Copyright © 2016年 JYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYangKeyChain : NSObject

+ (void)JYangKeyChainSave:(NSString *)service;

+ (NSString *)JYangKeyChainLoad;

+ (void)JYangKeyChainDelete:(NSString *)service;

@end
