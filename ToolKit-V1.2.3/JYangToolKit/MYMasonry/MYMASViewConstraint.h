//
//  MYMASViewConstraint.h
//  MYMASonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MYMASViewAttribute.h"
#import "MYMASConstraint.h"
#import "MYMASLayoutConstraint.h"
#import "MYMASUtilities.h"

/**
 *  A single constraint.
 *  Contains the attributes neccessary for creating a NSLayoutConstraint and adding it to the appropriate view
 */
@interface MYMASViewConstraint : MYMASConstraint <NSCopying>

/**
 *	First item/view and first attribute of the NSLayoutConstraint
 */
@property (nonatomic, strong, readonly) MYMASViewAttribute *firstViewAttribute;

/**
 *	Second item/view and second attribute of the NSLayoutConstraint
 */
@property (nonatomic, strong, readonly) MYMASViewAttribute *secondViewAttribute;

/**
 *	initialises the MYMASViewConstraint with the first part of the equation
 *
 *	@param	firstViewAttribute	view.MYMAS_left, view.MYMAS_width etc.
 *
 *	@return	a new view constraint
 */
- (id)initWithFirstViewAttribute:(MYMASViewAttribute *)firstViewAttribute;

/**
 *  Returns all MYMASViewConstraints installed with this view as a first item.
 *
 *  @param  view  A view to retrieve constraints for.
 *
 *  @return An array of MYMASViewConstraints.
 */
+ (NSArray *)installedConstraintsForView:(MYMAS_VIEW *)view;

@end
