//
//  UIScrollView+Extension.h
//  JrmfRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

@interface UIScrollView (JrmfExtension)
@property (assign, nonatomic) CGFloat jrmf_contentInsetTop;
@property (assign, nonatomic) CGFloat jrmf_contentInsetBottom;
@property (assign, nonatomic) CGFloat jrmf_contentInsetLeft;
@property (assign, nonatomic) CGFloat jrmf_contentInsetRight;

@property (assign, nonatomic) CGFloat jrmf_contentOffsetX;
@property (assign, nonatomic) CGFloat jrmf_contentOffsetY;

@property (assign, nonatomic) CGFloat jrmf_contentSizeWidth;
@property (assign, nonatomic) CGFloat jrmf_contentSizeHeight;
@end
