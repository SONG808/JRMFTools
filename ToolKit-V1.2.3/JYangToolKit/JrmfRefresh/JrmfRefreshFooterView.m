//
//  JrmfRefreshFooterView.m
//  JrmfRefresh
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  上拉加载更多

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "JrmfRefreshFooterView.h"
#import "JrmfRefreshConst.h"
#import "UIView+JrmfExtension.h"
#import "UIScrollView+JrmfExtension.h"

@interface JrmfRefreshFooterView()
@property (assign, nonatomic) int lastRefreshCount;
@end

@implementation JrmfRefreshFooterView

+ (instancetype)JrmfFooter
{
    return [[JrmfRefreshFooterView alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.pullToRefreshText = NSLocalizedStringFromTable(JrmfRefreshFooterPullToRefresh, @"JrmfInfo", nil);
        self.releaseToRefreshText = NSLocalizedStringFromTable(JrmfRefreshFooterReleaseToRefresh, @"JrmfInfo", nil);
        self.refreshingText = NSLocalizedStringFromTable(JrmfRefreshFooterRefreshing, @"JrmfInfo", nil);
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.statusLabel.frame = self.bounds;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:JrmfRefreshContentSize context:nil];
    
    if (newSuperview) { // 新的父控件
        // 监听
        [newSuperview addObserver:self forKeyPath:JrmfRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
        
        // 重新调整frame
        [self adjustFrameWithContentSize];
    }
}

#pragma mark 重写调整frame
- (void)adjustFrameWithContentSize
{
    // 内容的高度
    CGFloat contentHeight = self.scrollView.jrmf_contentSizeHeight;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.jrmf_height - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom;
    // 设置位置和尺寸
    self.jrmf_y = MAX(contentHeight, scrollHeight);
}

#pragma mark 监听UIScrollView的属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 不能跟用户交互，直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    if ([JrmfRefreshContentSize isEqualToString:keyPath]) {
        // 调整frame
        [self adjustFrameWithContentSize];
    } else if ([JrmfRefreshContentOffset isEqualToString:keyPath]) {
//* 注意： 这个返回一定要放这个位置
        // 如果正在刷新，直接返回
        if (self.state == JrmfRefreshStateRefreshing) return;
        
        // 调整状态
        [self adjustStateWithContentOffset];
    }
}

/**
 *  调整状态
 */
- (void)adjustStateWithContentOffset
{
    // 当前的contentOffset
    CGFloat currentOffsetY = self.scrollView.jrmf_contentOffsetY
    ;
    // 尾部控件刚好出现的offsetY
    CGFloat happenOffsetY = [self happenOffsetY];
    
    // 如果是向下滚动到看不见尾部控件，直接返回
    if (currentOffsetY <= happenOffsetY) return;
    
    if (self.scrollView.isDragging) {
        // 普通 和 即将刷新 的临界点
        CGFloat normal2pullingOffsetY = happenOffsetY + self.jrmf_height;
        
        if (self.state == JrmfRefreshStateNormal && currentOffsetY > normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = JrmfRefreshStatePulling;
        } else if (self.state == JrmfRefreshStatePulling && currentOffsetY <= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = JrmfRefreshStateNormal;
        }
    } else if (self.state == JrmfRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        self.state = JrmfRefreshStateRefreshing;
    }
}

#pragma mark - 状态相关
#pragma mark 设置状态
- (void)setState:(JrmfRefreshState)state
{
    // 1.一样的就直接返回
    if (self.state == state) return;
    
    // 2.保存旧状态
    JrmfRefreshState oldState = self.state;
    
    // 3.调用父类方法
    [super setState:state];
    
    // 4.根据状态来设置属性
	switch (state)
    {
		case JrmfRefreshStateNormal:
        {
            // 刷新完毕
            if (JrmfRefreshStateRefreshing == oldState) {
                self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                [UIView animateWithDuration:JrmfRefreshSlowAnimationDuration animations:^{
                    self.scrollView.jrmf_contentInsetBottom = self.scrollViewOriginalInset.bottom;
                }];
            } else {
                // 执行动画
                [UIView animateWithDuration:JrmfRefreshFastAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                }];
            }
            
            CGFloat deltaH = [self heightForContentBreakView];
            int currentCount = [self totalDataCountInScrollView];
            // 刚刷新完毕
            if (JrmfRefreshStateRefreshing == oldState && deltaH > 0 && currentCount != self.lastRefreshCount) {
                self.scrollView.jrmf_contentOffsetY = self.scrollView.jrmf_contentOffsetY;
            }
			break;
        }
            
		case JrmfRefreshStatePulling:
        {
            [UIView animateWithDuration:JrmfRefreshFastAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformIdentity;
            }];
			break;
        }
            
        case JrmfRefreshStateRefreshing:
        {
            // 记录刷新前的数量
            self.lastRefreshCount = [self totalDataCountInScrollView];
            
            [UIView animateWithDuration:JrmfRefreshFastAnimationDuration animations:^{
                CGFloat bottom = self.jrmf_height + self.scrollViewOriginalInset.bottom;
                CGFloat deltaH = [self heightForContentBreakView];
                if (deltaH < 0) { // 如果内容高度小于view的高度
                    bottom -= deltaH;
                }
                self.scrollView.jrmf_contentInsetBottom = bottom;
            }];
			break;
        }
            
        default:
            break;
	}
}

- (int)totalDataCountInScrollView
{
    int totalCount = 0;
    if ([self.scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.scrollView;
        
        for (int section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self.scrollView;
        
        for (int section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)heightForContentBreakView
{
    CGFloat h = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    return self.scrollView.contentSize.height - h;
}

#pragma mark - 在父类中用得上
/**
 *  刚好看到上拉刷新控件时的contentOffset.y
 */
- (CGFloat)happenOffsetY
{
    CGFloat deltaH = [self heightForContentBreakView];
    if (deltaH > 0) {
        return deltaH - self.scrollViewOriginalInset.top;
    } else {
        return - self.scrollViewOriginalInset.top;
    }
}
@end
