//
//  JYangStatiTool.h
//  JrmfPacketKit
//
//  Created by 一路财富 on 16/10/25.
//  Copyright © 2016年 JYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JYangStatiTool : NSObject

/**
 获取系统版本号

 @return 系统版本号 ex:iOS9
 */
+ (NSString *)getSystemVersion;

/**
 获取手机型号

 @return 手机型号 ex:iPhone 6
 */
+ (NSString *)getDeviceType;

/**
 获取应用名称

 @return 应用名称 ex:sealTalk
 */
+ (NSString *)getAppName;


@end
