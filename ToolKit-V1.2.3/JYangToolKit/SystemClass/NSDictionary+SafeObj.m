//
//  NSDictionary+SafeObj.m
//  JYangToolKit
//
//  Created by 一路财富 on 16/11/3.
//  Copyright © 2016年 JYang. All rights reserved.
//

#import "NSDictionary+SafeObj.h"

#define checkNull(__X__)        ((__X__) == [NSNull null] || (__X__) == nil) ? @"" : [NSString stringWithFormat:@"%@", (__X__)]

@implementation NSDictionary (SafeObj)

- (NSString *)safeObjectForKey:(id)key {
    return checkNull([self objectForKey:key]);
}

- (NSString *)jrmfSafeObjectForKey:(id)key {
    return checkNull([self objectForKey:key]);
}

@end
