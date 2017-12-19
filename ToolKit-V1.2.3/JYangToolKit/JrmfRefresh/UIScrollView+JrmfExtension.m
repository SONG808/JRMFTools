//
//  UIScrollView+Extension.m
//  JrmfRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "UIScrollView+JrmfExtension.h"

@implementation UIScrollView (JrmfExtension)

- (void)setJrmf_contentInsetTop:(CGFloat)jrmf_contentInsetTop
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = jrmf_contentInsetTop;
    self.contentInset = inset;
}

- (CGFloat)jrmf_contentInsetTop
{
    return self.contentInset.top;
}

- (void)setJrmf_contentInsetBottom:(CGFloat)jrmf_contentInsetBottom
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = jrmf_contentInsetBottom;
    self.contentInset = inset;
}

- (CGFloat)jrmf_contentInsetBottom
{
    return self.contentInset.bottom;
}

- (void)setJrmf_contentInsetLeft:(CGFloat)jrmf_contentInsetLeft
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = jrmf_contentInsetLeft;
    self.contentInset = inset;
}

- (CGFloat)jrmf_contentInsetLeft
{
    return self.contentInset.left;
}

- (void)setJrmf_contentInsetRight:(CGFloat)jrmf_contentInsetRight
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = jrmf_contentInsetRight;
    self.contentInset = inset;
}

- (CGFloat)jrmf_contentInsetRight
{
    return self.contentInset.right;
}

- (void)setJrmf_contentOffsetX:(CGFloat)jrmf_contentOffsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = jrmf_contentOffsetX;
    self.contentOffset = offset;
}

- (CGFloat)jrmf_contentOffsetX
{
    return self.contentOffset.x;
}

- (void)setJrmf_contentOffsetY:(CGFloat)jrmf_contentOffsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = jrmf_contentOffsetY;
    self.contentOffset = offset;
}

- (CGFloat)jrmf_contentOffsetY
{
    return self.contentOffset.y;
}

- (void)setJrmf_contentSizeWidth:(CGFloat)jrmf_contentSizeWidth
{
    CGSize size = self.contentSize;
    size.width = jrmf_contentSizeWidth;
    self.contentSize = size;
}

- (CGFloat)jrmf_contentSizeWidth
{
    return self.contentSize.width;
}

- (void)setJrmf_contentSizeHeight:(CGFloat)jrmf_contentSizeHeight
{
    CGSize size = self.contentSize;
    size.height = jrmf_contentSizeHeight;
    self.contentSize = size;
}

- (CGFloat)jrmf_contentSizeHeight
{
    return self.contentSize.height;
}
@end
