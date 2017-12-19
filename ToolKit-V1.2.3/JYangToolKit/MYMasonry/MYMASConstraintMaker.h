//
//  MYMASConstraintMaker.h
//  MYMASonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MYMASConstraint.h"
#import "MYMASUtilities.h"

typedef NS_OPTIONS(NSInteger, MYMASAttribute) {
    MYMASAttributeLeft = 1 << NSLayoutAttributeLeft,
    MYMASAttributeRight = 1 << NSLayoutAttributeRight,
    MYMASAttributeTop = 1 << NSLayoutAttributeTop,
    MYMASAttributeBottom = 1 << NSLayoutAttributeBottom,
    MYMASAttributeLeading = 1 << NSLayoutAttributeLeading,
    MYMASAttributeTrailing = 1 << NSLayoutAttributeTrailing,
    MYMASAttributeWidth = 1 << NSLayoutAttributeWidth,
    MYMASAttributeHeight = 1 << NSLayoutAttributeHeight,
    MYMASAttributeCenterX = 1 << NSLayoutAttributeCenterX,
    MYMASAttributeCenterY = 1 << NSLayoutAttributeCenterY,
    MYMASAttributeBaseline = 1 << NSLayoutAttributeBaseline,

    MYMASAttributeFirstBaseline = 1 << NSLayoutAttributeFirstBaseline,
    MYMASAttributeLastBaseline = 1 << NSLayoutAttributeLastBaseline,
    
#if TARGET_OS_IPHONE || TARGET_OS_TV
    
    MYMASAttributeLeftMargin = 1 << NSLayoutAttributeLeftMargin,
    MYMASAttributeRightMargin = 1 << NSLayoutAttributeRightMargin,
    MYMASAttributeTopMargin = 1 << NSLayoutAttributeTopMargin,
    MYMASAttributeBottomMargin = 1 << NSLayoutAttributeBottomMargin,
    MYMASAttributeLeadingMargin = 1 << NSLayoutAttributeLeadingMargin,
    MYMASAttributeTrailingMargin = 1 << NSLayoutAttributeTrailingMargin,
    MYMASAttributeCenterXWithinMargins = 1 << NSLayoutAttributeCenterXWithinMargins,
    MYMASAttributeCenterYWithinMargins = 1 << NSLayoutAttributeCenterYWithinMargins,

#endif
    
};

/**
 *  Provides factory methods for creating MYMASConstraints.
 *  Constraints are collected until they are ready to be installed
 *
 */
@interface MYMASConstraintMaker : NSObject

/**
 *	The following properties return a new MYMASViewConstraint
 *  with the first item set to the makers associated view and the appropriate MYMASViewAttribute
 */
@property (nonatomic, strong, readonly) MYMASConstraint *left;
@property (nonatomic, strong, readonly) MYMASConstraint *top;
@property (nonatomic, strong, readonly) MYMASConstraint *right;
@property (nonatomic, strong, readonly) MYMASConstraint *bottom;
@property (nonatomic, strong, readonly) MYMASConstraint *leading;
@property (nonatomic, strong, readonly) MYMASConstraint *trailing;
@property (nonatomic, strong, readonly) MYMASConstraint *width;
@property (nonatomic, strong, readonly) MYMASConstraint *height;
@property (nonatomic, strong, readonly) MYMASConstraint *centerX;
@property (nonatomic, strong, readonly) MYMASConstraint *centerY;
@property (nonatomic, strong, readonly) MYMASConstraint *baseline;

@property (nonatomic, strong, readonly) MYMASConstraint *firstBaseline;
@property (nonatomic, strong, readonly) MYMASConstraint *lastBaseline;

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, strong, readonly) MYMASConstraint *leftMargin;
@property (nonatomic, strong, readonly) MYMASConstraint *rightMargin;
@property (nonatomic, strong, readonly) MYMASConstraint *topMargin;
@property (nonatomic, strong, readonly) MYMASConstraint *bottomMargin;
@property (nonatomic, strong, readonly) MYMASConstraint *leadingMargin;
@property (nonatomic, strong, readonly) MYMASConstraint *trailingMargin;
@property (nonatomic, strong, readonly) MYMASConstraint *centerXWithinMargins;
@property (nonatomic, strong, readonly) MYMASConstraint *centerYWithinMargins;

#endif

/**
 *  Returns a block which creates a new MYMASCompositeConstraint with the first item set
 *  to the makers associated view and children corresponding to the set bits in the
 *  MYMASAttribute parameter. Combine multiple attributes via binary-or.
 */
@property (nonatomic, strong, readonly) MYMASConstraint *(^attributes)(MYMASAttribute attrs);

/**
 *	Creates a MYMASCompositeConstraint with type MYMASCompositeConstraintTypeEdges
 *  which generates the appropriate MYMASViewConstraint children (top, left, bottom, right)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) MYMASConstraint *edges;

/**
 *	Creates a MYMASCompositeConstraint with type MYMASCompositeConstraintTypeSize
 *  which generates the appropriate MYMASViewConstraint children (width, height)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) MYMASConstraint *size;

/**
 *	Creates a MYMASCompositeConstraint with type MYMASCompositeConstraintTypeCenter
 *  which generates the appropriate MYMASViewConstraint children (centerX, centerY)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) MYMASConstraint *center;

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *  Whether or not to remove existing constraints prior to installing
 */
@property (nonatomic, assign) BOOL removeExisting;

/**
 *	initialises the maker with a default view
 *
 *	@param	view	any MYMASConstraint are created with this view as the first item
 *
 *	@return	a new MYMASConstraintMaker
 */
- (id)initWithView:(MYMAS_VIEW *)view;

/**
 *	Calls install method on any MYMASConstraints which have been created by this maker
 *
 *	@return	an array of all the installed MYMASConstraints
 */
- (NSArray *)install;

- (MYMASConstraint * (^)(dispatch_block_t))group;

@end
