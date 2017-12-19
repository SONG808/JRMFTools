//
//  MYMASCompositeConstraint.h
//  MYMASonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MYMASConstraint.h"
#import "MYMASUtilities.h"

/**
 *	A group of MYMASConstraint objects
 */
@interface MYMASCompositeConstraint : MYMASConstraint

/**
 *	Creates a composite with a predefined array of children
 *
 *	@param	children	child MYMASConstraints
 *
 *	@return	a composite constraint
 */
- (id)initWithChildren:(NSArray *)children;

@end
