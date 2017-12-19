//
//  UIView+MYMASAdditions.h
//  MYMASonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MYMASUtilities.h"
#import "MYMASConstraintMaker.h"
#import "MYMASViewAttribute.h"

/**
 *	Provides constraint maker block
 *  and convience methods for creating MYMASViewAttribute which are view + NSLayoutAttribute pairs
 */
@interface MYMAS_VIEW (MYMASAdditions)

/**
 *	following properties return a new MYMASViewAttribute with current view and appropriate NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_left;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_top;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_right;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_bottom;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_leading;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_trailing;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_width;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_height;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_centerX;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_centerY;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_baseline;
@property (nonatomic, strong, readonly) MYMASViewAttribute *(^MYMAS_attribute)(NSLayoutAttribute attr);

@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_firstBaseline;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_lastBaseline;

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_leftMargin;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_rightMargin;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_topMargin;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_bottomMargin;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_leadingMargin;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_trailingMargin;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_centerXWithinMargins;
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_centerYWithinMargins;

@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_safeAreaLayoutGuide NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_safeAreaLayoutGuideLeading NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_safeAreaLayoutGuideTrailing NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_safeAreaLayoutGuideLeft NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_safeAreaLayoutGuideRight NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_safeAreaLayoutGuideTop NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_safeAreaLayoutGuideBottom NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_safeAreaLayoutGuideWidth NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_safeAreaLayoutGuideHeight NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_safeAreaLayoutGuideCenterX NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_safeAreaLayoutGuideCenterY NS_AVAILABLE_IOS(11.0);

#endif

/**
 *	a key to associate with this view
 */
@property (nonatomic, strong) id MYMAS_key;

/**
 *	Finds the closest common superview between this view and another view
 *
 *	@param	view	other view
 *
 *	@return	returns nil if common superview could not be found
 */
- (instancetype)MYMAS_closestCommonSuperview:(MYMAS_VIEW *)view;

/**
 *  Creates a MYMASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created MYMASConstraints
 */
- (NSArray *)MYMAS_makeConstraints:(void(NS_NOESCAPE ^)(MYMASConstraintMaker *make))block;

/**
 *  Creates a MYMASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MYMASConstraints
 */
- (NSArray *)MYMAS_updateConstraints:(void(NS_NOESCAPE ^)(MYMASConstraintMaker *make))block;

/**
 *  Creates a MYMASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  All constraints previously installed for the view will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MYMASConstraints
 */
- (NSArray *)MYMAS_remakeConstraints:(void(NS_NOESCAPE ^)(MYMASConstraintMaker *make))block;

@end
