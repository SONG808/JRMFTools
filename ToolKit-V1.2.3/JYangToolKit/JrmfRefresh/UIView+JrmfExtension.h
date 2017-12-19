//
//  UIView+Extension.h
//  JrmfRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

@interface UIView (JrmfExtension)
@property (assign, nonatomic) CGFloat jrmf_x;
@property (assign, nonatomic) CGFloat jrmf_y;
@property (assign, nonatomic) CGFloat jrmf_width;
@property (assign, nonatomic) CGFloat jrmf_height;
@property (assign, nonatomic) CGSize jrmf_size;
@property (assign, nonatomic) CGPoint jrmf_origin;
@end
