//
//  UIScrollView+JrmfRefresh.m
//  JrmfRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "UIScrollView+JrmfRefresh.h"
#import "JrmfRefreshHeaderView.h"
#import "JrmfRefreshFooterView.h"
#import <objc/runtime.h>

@interface UIScrollView()
@property (weak, nonatomic) JrmfRefreshHeaderView *Jrmfheader;
@property (weak, nonatomic) JrmfRefreshFooterView *Jrmffooter;
@end


@implementation UIScrollView (JrmfRefresh)

#pragma mark - 运行时相关
static char JrmfRefreshHeaderViewKey;
static char JrmfRefreshFooterViewKey;

//- (void)setHeader:(JrmfRefreshHeaderView *)header {
//    [self willChangeValueForKey:@"JrmfRefreshHeaderViewKey"];
//    objc_setAssociatedObject(self, &JrmfRefreshHeaderViewKey,
//                             header,
//                             OBJC_ASSOCIATION_ASSIGN);
//    [self didChangeValueForKey:@"JrmfRefreshHeaderViewKey"];
//}
- (void)setJrmfheader:(JrmfRefreshHeaderView *)Jrmfheader {
    [self willChangeValueForKey:@"JrmfRefreshHeaderViewKey"];
    objc_setAssociatedObject(self, &JrmfRefreshHeaderViewKey,
                             Jrmfheader,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"JrmfRefreshHeaderViewKey"];
}

//- (JrmfRefreshHeaderView *)header {
//    return objc_getAssociatedObject(self, &JrmfRefreshHeaderViewKey);
//}
- (JrmfRefreshHeaderView *)Jrmfheader {
    return objc_getAssociatedObject(self, &JrmfRefreshHeaderViewKey);
}

//- (void)setFooter:(JrmfRefreshFooterView *)footer {
//    [self willChangeValueForKey:@"JrmfRefreshFooterViewKey"];
//    objc_setAssociatedObject(self, &JrmfRefreshFooterViewKey,
//                             footer,
//                             OBJC_ASSOCIATION_ASSIGN);
//    [self didChangeValueForKey:@"JrmfRefreshFooterViewKey"];
//}
- (void)setJrmffooter:(JrmfRefreshFooterView *)Jrmffooter {
    [self willChangeValueForKey:@"JrmfRefreshFooterViewKey"];
    objc_setAssociatedObject(self, &JrmfRefreshFooterViewKey,
                             Jrmffooter,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"JrmfRefreshFooterViewKey"];
}

//- (JrmfRefreshFooterView *)footer {
//    return objc_getAssociatedObject(self, &JrmfRefreshFooterViewKey);
//}

- (JrmfRefreshFooterView *)Jrmffooter {
    return objc_getAssociatedObject(self, &JrmfRefreshFooterViewKey);
}

#pragma mark - 下拉刷新
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)addJrmfHeaderWithCallback:(void (^)())callback
{
    // 1.创建新的header
    if (!self.Jrmfheader) {
        JrmfRefreshHeaderView *header = [JrmfRefreshHeaderView JrmfHeader];
        [self addSubview:header];
        self.Jrmfheader = header;
    }
    
    // 2.设置block回调
    self.Jrmfheader.beginRefreshingCallback = callback;
}

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addJrmfHeaderWithTarget:(id)target action:(SEL)action
{
    // 1.创建新的header
    if (!self.Jrmfheader) {
        JrmfRefreshHeaderView *header = [JrmfRefreshHeaderView JrmfHeader];
        [self addSubview:header];
        self.Jrmfheader = header;
    }
    
    // 2.设置目标和回调方法
    self.Jrmfheader.beginRefreshingTaget = target;
    self.Jrmfheader.beginRefreshingAction = action;
}

/**
 *  移除下拉刷新头部控件
 */
- (void)removeJrmfHeader
{
    [self.Jrmfheader removeFromSuperview];
    self.Jrmfheader = nil;
}

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)JrmfheaderBeginRefreshing
{
    [self.Jrmfheader beginRefreshing];
}

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)JrmfheaderEndRefreshing
{
    [self.Jrmfheader endRefreshing];
}

/**
 *  下拉刷新头部控件的可见性
 */
- (void)setJrmfheaderHidden:(BOOL)JrmfheaderHidden
{
    self.Jrmfheader.hidden = JrmfheaderHidden;
}

- (BOOL)isJrmfHeaderHidden
{
    return self.Jrmfheader.isHidden;
}

- (BOOL)isJrmfHeaderRefreshing
{
    return self.Jrmfheader.state == JrmfRefreshStateRefreshing;
}

#pragma mark - 上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)addJrmfFooterWithCallback:(void (^)())callback
{
    // 1.创建新的footer
    if (!self.Jrmffooter) {
        JrmfRefreshFooterView *footer = [JrmfRefreshFooterView JrmfFooter];
        [self addSubview:footer];
        self.Jrmffooter = footer;
    }
    
    // 2.设置block回调
    self.Jrmffooter.beginRefreshingCallback = callback;
}

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addJrmfFooterWithTarget:(id)target action:(SEL)action
{
    // 1.创建新的footer
    if (!self.Jrmffooter) {
        JrmfRefreshFooterView *footer = [JrmfRefreshFooterView JrmfFooter];
        [self addSubview:footer];
        self.Jrmffooter = footer;
    }
    
    // 2.设置目标和回调方法
    self.Jrmffooter.beginRefreshingTaget = target;
    self.Jrmffooter.beginRefreshingAction = action;
}

/**
 *  移除上拉刷新尾部控件
 */
- (void)removeJrmfFooter
{
    [self.Jrmffooter removeFromSuperview];
    self.Jrmffooter = nil;
}

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)JrmffooterBeginRefreshing
{
    [self.Jrmffooter beginRefreshing];
}

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)JrmffooterEndRefreshing
{
    [self.Jrmffooter endRefreshing];
}

/**
 *  下拉刷新头部控件的可见性
 */
- (void)setJrmffooterHidden:(BOOL)JrmffooterHidden
{
    self.Jrmffooter.hidden = JrmffooterHidden;
}

- (BOOL)isJrmfFooterHidden
{
    return self.Jrmffooter.isHidden;
}

- (BOOL)isJrmfFooterRefreshing
{
    return self.Jrmffooter.state == JrmfRefreshStateRefreshing;
}

/**
 *  文字
 */
- (void)setJrmffooterPullToRefreshText:(NSString *)JrmffooterPullToRefreshText
{
    self.Jrmffooter.pullToRefreshText = JrmffooterPullToRefreshText;
}

- (NSString *)JrmffooterPullToRefreshText
{
    return self.Jrmffooter.pullToRefreshText;
}

- (void)setJrmffooterReleaseToRefreshText:(NSString *)JrmffooterReleaseToRefreshText
{
    self.Jrmffooter.releaseToRefreshText = JrmffooterReleaseToRefreshText;
}

- (NSString *)JrmffooterReleaseToRefreshText
{
    return self.Jrmffooter.releaseToRefreshText;
}

- (void)setJrmffooterRefreshingText:(NSString *)JrmffooterRefreshingText
{
    self.Jrmffooter.refreshingText = JrmffooterRefreshingText;
}

- (NSString *)JrmffooterRefreshingText
{
    return self.Jrmffooter.refreshingText;
}

- (void)setJrmfheaderPullToRefreshText:(NSString *)JrmfheaderPullToRefreshText
{
    self.Jrmfheader.pullToRefreshText = JrmfheaderPullToRefreshText;
}

- (NSString *)JrmfheaderPullToRefreshText
{
    return self.Jrmfheader.pullToRefreshText;
}

- (void)setJrmfheaderReleaseToRefreshText:(NSString *)JrmfheaderReleaseToRefreshText
{
    self.Jrmfheader.releaseToRefreshText = JrmfheaderReleaseToRefreshText;
}

- (NSString *)JrmfheaderReleaseToRefreshText
{
    return self.Jrmfheader.releaseToRefreshText;
}

- (void)setJrmfheaderRefreshingText:(NSString *)JrmfheaderRefreshingText
{
    self.Jrmfheader.refreshingText = JrmfheaderRefreshingText;
}

- (NSString *)JrmfheaderRefreshingText
{
    return self.Jrmfheader.refreshingText;
}
@end
