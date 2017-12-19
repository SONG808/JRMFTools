//
//  JrmfRefreshConst.h
//  JrmfRefresh
//
//  Created by mj on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

#ifdef DEBUG
#define JrmfLog(...) NSLog(__VA_ARGS__)
#else
#define JrmfLog(...)
#endif

// objc_msgSend
#define msgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)

#define MJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 文字颜色
#define JrmfRefreshLabelTextColor MJColor(150, 150, 150)

extern const CGFloat JrmfRefreshViewHeight;
extern const CGFloat JrmfRefreshFastAnimationDuration;
extern const CGFloat JrmfRefreshSlowAnimationDuration;

extern NSString *const JrmfRefreshBundleName;
#define JrmfRefreshSrcName(file) [JrmfRefreshBundleName stringByAppendingPathComponent:file]

extern NSString *const JrmfRefreshFooterPullToRefresh;
extern NSString *const JrmfRefreshFooterReleaseToRefresh;
extern NSString *const JrmfRefreshFooterRefreshing;

extern NSString *const JrmfRefreshHeaderPullToRefresh;
extern NSString *const JrmfRefreshHeaderReleaseToRefresh;
extern NSString *const JrmfRefreshHeaderRefreshing;
extern NSString *const JrmfRefreshHeaderTimeKey;

extern NSString *const JrmfRefreshContentOffset;
extern NSString *const JrmfRefreshContentSize;
