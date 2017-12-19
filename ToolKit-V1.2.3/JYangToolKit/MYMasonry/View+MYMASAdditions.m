//
//  UIView+MYMASAdditions.m
//  MYMASonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "View+MYMASAdditions.h"
#import <objc/runtime.h>

@implementation MYMAS_VIEW (MYMASAdditions)

- (NSArray *)MYMAS_makeConstraints:(void(^)(MYMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    MYMASConstraintMaker *constraintMaker = [[MYMASConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)MYMAS_updateConstraints:(void(^)(MYMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    MYMASConstraintMaker *constraintMaker = [[MYMASConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)MYMAS_remakeConstraints:(void(^)(MYMASConstraintMaker *make))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    MYMASConstraintMaker *constraintMaker = [[MYMASConstraintMaker alloc] initWithView:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (MYMASViewAttribute *)MYMAS_left {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}

- (MYMASViewAttribute *)MYMAS_top {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}

- (MYMASViewAttribute *)MYMAS_right {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}

- (MYMASViewAttribute *)MYMAS_bottom {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}

- (MYMASViewAttribute *)MYMAS_leading {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
}

- (MYMASViewAttribute *)MYMAS_trailing {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (MYMASViewAttribute *)MYMAS_width {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}

- (MYMASViewAttribute *)MYMAS_height {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}

- (MYMASViewAttribute *)MYMAS_centerX {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (MYMASViewAttribute *)MYMAS_centerY {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (MYMASViewAttribute *)MYMAS_baseline {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
}

- (MYMASViewAttribute *(^)(NSLayoutAttribute))MYMAS_attribute
{
    return ^(NSLayoutAttribute attr) {
        return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:attr];
    };
}

- (MYMASViewAttribute *)MYMAS_firstBaseline {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeFirstBaseline];
}
- (MYMASViewAttribute *)MYMAS_lastBaseline {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLastBaseline];
}

#if TARGET_OS_IPHONE || TARGET_OS_TV

- (MYMASViewAttribute *)MYMAS_leftMargin {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeftMargin];
}

- (MYMASViewAttribute *)MYMAS_rightMargin {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRightMargin];
}

- (MYMASViewAttribute *)MYMAS_topMargin {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTopMargin];
}

- (MYMASViewAttribute *)MYMAS_bottomMargin {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottomMargin];
}

- (MYMASViewAttribute *)MYMAS_leadingMargin {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (MYMASViewAttribute *)MYMAS_trailingMargin {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (MYMASViewAttribute *)MYMAS_centerXWithinMargins {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (MYMASViewAttribute *)MYMAS_centerYWithinMargins {
    return [[MYMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

- (MYMASViewAttribute *)MYMAS_safeAreaLayoutGuide {
    return [[MYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeNotAnAttribute];
}

- (MYMASViewAttribute *)MYMAS_safeAreaLayoutGuideLeading {
    return [[MYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeLeading];
}

- (MYMASViewAttribute *)MYMAS_safeAreaLayoutGuideTrailing {
    return [[MYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeTrailing];
}

- (MYMASViewAttribute *)MYMAS_safeAreaLayoutGuideLeft {
    return [[MYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeLeft];
}

- (MYMASViewAttribute *)MYMAS_safeAreaLayoutGuideRight {
    return [[MYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeRight];
}

- (MYMASViewAttribute *)MYMAS_safeAreaLayoutGuideTop {
    return [[MYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}

- (MYMASViewAttribute *)MYMAS_safeAreaLayoutGuideBottom {
    return [[MYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (MYMASViewAttribute *)MYMAS_safeAreaLayoutGuideWidth {
    return [[MYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeWidth];
}

- (MYMASViewAttribute *)MYMAS_safeAreaLayoutGuideHeight {
    return [[MYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeHeight];
}

- (MYMASViewAttribute *)MYMAS_safeAreaLayoutGuideCenterX {
    return [[MYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeCenterX];
}

- (MYMASViewAttribute *)MYMAS_safeAreaLayoutGuideCenterY {
    return [[MYMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeCenterY];
}

#endif

#pragma mark - associated properties

- (id)MYMAS_key {
    return objc_getAssociatedObject(self, @selector(MYMAS_key));
}

- (void)setMYMAS_key:(id)key {
    objc_setAssociatedObject(self, @selector(MYMAS_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

- (instancetype)MYMAS_closestCommonSuperview:(MYMAS_VIEW *)view {
    MYMAS_VIEW *closestCommonSuperview = nil;

    MYMAS_VIEW *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        MYMAS_VIEW *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
