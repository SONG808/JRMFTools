//
//  UIView+MYMASShorthandAdditions.h
//  MYMASonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "View+MYMASAdditions.h"

#ifdef MYMAS_SHORTHAND

/**
 *	Shorthand view additions without the 'MYMAS_' prefixes,
 *  only enabled if MYMAS_SHORTHAND is defined
 */
@interface MYMAS_VIEW (MYMASShorthandAdditions)

@property (nonatomic, strong, readonly) MYMASViewAttribute *left;
@property (nonatomic, strong, readonly) MYMASViewAttribute *top;
@property (nonatomic, strong, readonly) MYMASViewAttribute *right;
@property (nonatomic, strong, readonly) MYMASViewAttribute *bottom;
@property (nonatomic, strong, readonly) MYMASViewAttribute *leading;
@property (nonatomic, strong, readonly) MYMASViewAttribute *trailing;
@property (nonatomic, strong, readonly) MYMASViewAttribute *width;
@property (nonatomic, strong, readonly) MYMASViewAttribute *height;
@property (nonatomic, strong, readonly) MYMASViewAttribute *centerX;
@property (nonatomic, strong, readonly) MYMASViewAttribute *centerY;
@property (nonatomic, strong, readonly) MYMASViewAttribute *baseline;
@property (nonatomic, strong, readonly) MYMASViewAttribute *(^attribute)(NSLayoutAttribute attr);

@property (nonatomic, strong, readonly) MYMASViewAttribute *firstBaseline;
@property (nonatomic, strong, readonly) MYMASViewAttribute *lastBaseline;

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, strong, readonly) MYMASViewAttribute *leftMargin;
@property (nonatomic, strong, readonly) MYMASViewAttribute *rightMargin;
@property (nonatomic, strong, readonly) MYMASViewAttribute *topMargin;
@property (nonatomic, strong, readonly) MYMASViewAttribute *bottomMargin;
@property (nonatomic, strong, readonly) MYMASViewAttribute *leadingMargin;
@property (nonatomic, strong, readonly) MYMASViewAttribute *trailingMargin;
@property (nonatomic, strong, readonly) MYMASViewAttribute *centerXWithinMargins;
@property (nonatomic, strong, readonly) MYMASViewAttribute *centerYWithinMargins;

#endif

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, strong, readonly) MYMASViewAttribute *safeAreaLayoutGuideLeading NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *safeAreaLayoutGuideTrailing NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *safeAreaLayoutGuideLeft NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *safeAreaLayoutGuideRight NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *safeAreaLayoutGuideTop NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *safeAreaLayoutGuideBottom NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *safeAreaLayoutGuideWidth NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *safeAreaLayoutGuideHeight NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *safeAreaLayoutGuideCenterX NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *safeAreaLayoutGuideCenterY NS_AVAILABLE_IOS(11.0);

#endif

- (NSArray *)makeConstraints:(void(^)(MYMASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(MYMASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(MYMASConstraintMaker *make))block;

@end

#define MYMAS_ATTR_FORWARD(attr)  \
- (MYMASViewAttribute *)attr {    \
    return [self MYMAS_##attr];   \
}

#define MYMAS_ATTR_FORWARD_AVAILABLE(attr, available)  \
- (MYMASViewAttribute *)attr available {    \
    return [self MYMAS_##attr];   \
}

@implementation MYMAS_VIEW (MYMASShorthandAdditions)

MYMAS_ATTR_FORWARD(top);
MYMAS_ATTR_FORWARD(left);
MYMAS_ATTR_FORWARD(bottom);
MYMAS_ATTR_FORWARD(right);
MYMAS_ATTR_FORWARD(leading);
MYMAS_ATTR_FORWARD(trailing);
MYMAS_ATTR_FORWARD(width);
MYMAS_ATTR_FORWARD(height);
MYMAS_ATTR_FORWARD(centerX);
MYMAS_ATTR_FORWARD(centerY);
MYMAS_ATTR_FORWARD(baseline);

MYMAS_ATTR_FORWARD(firstBaseline);
MYMAS_ATTR_FORWARD(lastBaseline);

#if TARGET_OS_IPHONE || TARGET_OS_TV

MYMAS_ATTR_FORWARD(leftMargin);
MYMAS_ATTR_FORWARD(rightMargin);
MYMAS_ATTR_FORWARD(topMargin);
MYMAS_ATTR_FORWARD(bottomMargin);
MYMAS_ATTR_FORWARD(leadingMargin);
MYMAS_ATTR_FORWARD(trailingMargin);
MYMAS_ATTR_FORWARD(centerXWithinMargins);
MYMAS_ATTR_FORWARD(centerYWithinMargins);

MYMAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideLeading, NS_AVAILABLE_IOS(11.0));
MYMAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideTrailing, NS_AVAILABLE_IOS(11.0));
MYMAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideLeft, NS_AVAILABLE_IOS(11.0));
MYMAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideRight, NS_AVAILABLE_IOS(11.0));
MYMAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideTop, NS_AVAILABLE_IOS(11.0));
MYMAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideBottom, NS_AVAILABLE_IOS(11.0));
MYMAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideWidth, NS_AVAILABLE_IOS(11.0));
MYMAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideHeight, NS_AVAILABLE_IOS(11.0));
MYMAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideCenterX, NS_AVAILABLE_IOS(11.0));
MYMAS_ATTR_FORWARD_AVAILABLE(safeAreaLayoutGuideCenterY, NS_AVAILABLE_IOS(11.0));

#endif

- (MYMASViewAttribute *(^)(NSLayoutAttribute))attribute {
    return [self MYMAS_attribute];
}

- (NSArray *)makeConstraints:(void(NS_NOESCAPE ^)(MYMASConstraintMaker *))block {
    return [self MYMAS_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(NS_NOESCAPE ^)(MYMASConstraintMaker *))block {
    return [self MYMAS_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(NS_NOESCAPE ^)(MYMASConstraintMaker *))block {
    return [self MYMAS_remakeConstraints:block];
}

@end

#endif
