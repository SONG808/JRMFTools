//
//  UIView+Extension.m
//  JrmfRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "UIView+JrmfExtension.h"

@implementation UIView (JrmfExtension)

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
@end
