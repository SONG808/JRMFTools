//
//  JrmfRefreshBaseView.h
//  JrmfRefresh
//  
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

@class JrmfRefreshBaseView;

#pragma mark - 控件的刷新状态
typedef enum {
	JrmfRefreshStatePulling = 1, // 松开就可以进行刷新的状态
	JrmfRefreshStateNormal = 2, // 普通状态
	JrmfRefreshStateRefreshing = 3, // 正在刷新中的状态
    JrmfRefreshStateWillRefreshing = 4
} JrmfRefreshState;

#pragma mark - 控件的类型
typedef enum {
    JrmfRefreshViewTypeHeader = -1, // 头部控件
    JrmfRefreshViewTypeFooter = 1 // 尾部控件
} JrmfRefreshViewType;

/**
 类的声明
 */
@interface JrmfRefreshBaseView : UIView
#pragma mark - 父控件
@property (nonatomic, weak, readonly) UIScrollView *scrollView;
@property (nonatomic, assign, readonly) UIEdgeInsets scrollViewOriginalInset;

#pragma mark - 内部的控件
@property (nonatomic, weak, readonly) UILabel *statusLabel;
@property (nonatomic, weak, readonly) UIImageView *arrowImage;
@property (nonatomic, weak, readonly) UIActivityIndicatorView *activityView;

#pragma mark - 回调
/**
 *  开始进入刷新状态的监听器
 */
@property (weak, nonatomic) id beginRefreshingTaget;
/**
 *  开始进入刷新状态的监听方法
 */
@property (assign, nonatomic) SEL beginRefreshingAction;
/**
 *  开始进入刷新状态就会调用
 */
@property (nonatomic, copy) void (^beginRefreshingCallback)();

#pragma mark - 刷新相关
/**
 *  是否正在刷新
 */
@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;
/**
 *  开始刷新
 */
- (void)beginRefreshing;
/**
 *  结束刷新
 */
- (void)endRefreshing;

#pragma mark - 交给子类去实现 和 调用
@property (assign, nonatomic) JrmfRefreshState state;

/**
 *  文字
 */
@property (copy, nonatomic) NSString *pullToRefreshText;
@property (copy, nonatomic) NSString *releaseToRefreshText;
@property (copy, nonatomic) NSString *refreshingText;
@end
