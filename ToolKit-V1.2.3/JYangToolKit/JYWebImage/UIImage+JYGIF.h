//
//  UIImage+JYGIF.h
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JYGIF)

+ (UIImage *)jy_animatedGIFNamed:(NSString *)name;

+ (UIImage *)jy_animatedGIFWithData:(NSData *)data;

- (UIImage *)jy_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
