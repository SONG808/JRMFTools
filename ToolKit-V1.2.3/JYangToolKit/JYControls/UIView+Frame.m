//
//  UIView+Frame.m
//  JrmfWalletKit
//
//  Created by 一路财富 on 16/11/2.
//  Copyright © 2016年 JYang. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setJrmf_x:(CGFloat)jrmf_x
{
    CGRect frame = self.frame;
    frame.origin.x = jrmf_x;
    self.frame = frame;
}
- (CGFloat)jrmf_x
{
    return self.frame.origin.x;
}

- (void)setJrmf_y:(CGFloat)jrmf_y
{
    CGRect frame = self.frame;
    frame.origin.y = jrmf_y;
    self.frame = frame;
}

- (CGFloat)jrmf_y
{
    return self.frame.origin.y;
}

- (void)setJrmf_origin:(CGPoint)jrmf_origin
{
    CGRect frame = self.frame;
    frame.origin = jrmf_origin;
    self.frame = frame;
}

- (CGPoint)jrmf_origin
{
    return self.frame.origin;
}

- (void)setJrmf_width:(CGFloat)jrmf_width
{
    CGRect frame = self.frame;
    frame.size.width = jrmf_width;
    self.frame = frame;
}

- (CGFloat)jrmf_width
{
    return self.frame.size.width;
}

- (void)setJrmf_height:(CGFloat)jrmf_height
{
    CGRect frame = self.frame;
    frame.size.height = jrmf_height;
    self.frame = frame;
}

- (CGFloat)jrmf_height
{
    return self.frame.size.height;
}

- (void)setJrmf_size:(CGSize)jrmf_size
{
    CGRect frame = self.frame;
    frame.size = jrmf_size;
    self.frame = frame;
}

- (CGSize)jrmf_size
{
    return self.frame.size;
}

- (void)setJrmf_centerX:(CGFloat)jrmf_centerX
{
    CGPoint center = self.center;
    center.x = jrmf_centerX;
    self.center = center;
}

- (CGFloat)jrmf_centerX
{
    return self.center.x;
}

- (void)setJrmf_centerY:(CGFloat)jrmf_centerY
{
    CGPoint center = self.center;
    center.y = jrmf_centerY;
    self.center = center;
}

- (CGFloat)jrmf_centerY
{
    return self.center.y;
}

@end
