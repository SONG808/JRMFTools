//
//  MYMASConstraint.h
//  MYMASonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MYMASUtilities.h"

/**
 *	Enables Constraints to be created with chainable syntax
 *  Constraint can represent single NSLayoutConstraint (MYMASViewConstraint)
 *  or a group of NSLayoutConstraints (MYMASComposisteConstraint)
 */
@interface MYMASConstraint : NSObject

// Chaining Support

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MYMASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (MYMASConstraint * (^)(MYMASEdgeInsets insets))insets;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MYMASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (MYMASConstraint * (^)(CGFloat inset))inset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MYMASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeWidth, NSLayoutAttributeHeight
 */
- (MYMASConstraint * (^)(CGSize offset))sizeOffset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MYMASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeCenterX, NSLayoutAttributeCenterY
 */
- (MYMASConstraint * (^)(CGPoint offset))centerOffset;

/**
 *	Modifies the NSLayoutConstraint constant
 */
- (MYMASConstraint * (^)(CGFloat offset))offset;

/**
 *  Modifies the NSLayoutConstraint constant based on a value type
 */
- (MYMASConstraint * (^)(NSValue *value))valueOffset;

/**
 *	Sets the NSLayoutConstraint multiplier property
 */
- (MYMASConstraint * (^)(CGFloat multiplier))multipliedBy;

/**
 *	Sets the NSLayoutConstraint multiplier to 1.0/dividedBy
 */
- (MYMASConstraint * (^)(CGFloat divider))dividedBy;

/**
 *	Sets the NSLayoutConstraint priority to a float or MYMASLayoutPriority
 */
- (MYMASConstraint * (^)(MYMASLayoutPriority priority))priority;

/**
 *	Sets the NSLayoutConstraint priority to MYMASLayoutPriorityLow
 */
- (MYMASConstraint * (^)(void))priorityLow;

/**
 *	Sets the NSLayoutConstraint priority to MYMASLayoutPriorityMedium
 */
- (MYMASConstraint * (^)(void))priorityMedium;

/**
 *	Sets the NSLayoutConstraint priority to MYMASLayoutPriorityHigh
 */
- (MYMASConstraint * (^)(void))priorityHigh;

/**
 *	Sets the constraint relation to NSLayoutRelationEqual
 *  returns a block which accepts one of the following:
 *    MYMASViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (MYMASConstraint * (^)(id attr))equalTo;

/**
 *	Sets the constraint relation to NSLayoutRelationGreaterThanOrEqual
 *  returns a block which accepts one of the following:
 *    MYMASViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (MYMASConstraint * (^)(id attr))greaterThanOrEqualTo;

/**
 *	Sets the constraint relation to NSLayoutRelationLessThanOrEqual
 *  returns a block which accepts one of the following:
 *    MYMASViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (MYMASConstraint * (^)(id attr))lessThanOrEqualTo;

/**
 *	Optional semantic property which has no effect but improves the readability of constraint
 */
- (MYMASConstraint *)with;

/**
 *	Optional semantic property which has no effect but improves the readability of constraint
 */
- (MYMASConstraint *)and;

/**
 *	Creates a new MYMASCompositeConstraint with the called attribute and reciever
 */
- (MYMASConstraint *)left;
- (MYMASConstraint *)top;
- (MYMASConstraint *)right;
- (MYMASConstraint *)bottom;
- (MYMASConstraint *)leading;
- (MYMASConstraint *)trailing;
- (MYMASConstraint *)width;
- (MYMASConstraint *)height;
- (MYMASConstraint *)centerX;
- (MYMASConstraint *)centerY;
- (MYMASConstraint *)baseline;

- (MYMASConstraint *)firstBaseline;
- (MYMASConstraint *)lastBaseline;

#if TARGET_OS_IPHONE || TARGET_OS_TV

- (MYMASConstraint *)leftMargin;
- (MYMASConstraint *)rightMargin;
- (MYMASConstraint *)topMargin;
- (MYMASConstraint *)bottomMargin;
- (MYMASConstraint *)leadingMargin;
- (MYMASConstraint *)trailingMargin;
- (MYMASConstraint *)centerXWithinMargins;
- (MYMASConstraint *)centerYWithinMargins;

#endif


/**
 *	Sets the constraint debug name
 */
- (MYMASConstraint * (^)(id key))key;

// NSLayoutConstraint constant Setters
// for use outside of MYMAS_updateConstraints/MYMAS_makeConstraints blocks

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MYMASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (void)setInsets:(MYMASEdgeInsets)insets;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MYMASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (void)setInset:(CGFloat)inset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MYMASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeWidth, NSLayoutAttributeHeight
 */
- (void)setSizeOffset:(CGSize)sizeOffset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects MYMASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeCenterX, NSLayoutAttributeCenterY
 */
- (void)setCenterOffset:(CGPoint)centerOffset;

/**
 *	Modifies the NSLayoutConstraint constant
 */
- (void)setOffset:(CGFloat)offset;


// NSLayoutConstraint Installation support

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)
/**
 *  Whether or not to go through the animator proxy when modifying the constraint
 */
@property (nonatomic, copy, readonly) MYMASConstraint *animator;
#endif

/**
 *  Activates an NSLayoutConstraint if it's supported by an OS. 
 *  Invokes install otherwise.
 */
- (void)activate;

/**
 *  Deactivates previously installed/activated NSLayoutConstraint.
 */
- (void)deactivate;

/**
 *	Creates a NSLayoutConstraint and adds it to the appropriate view.
 */
- (void)install;

/**
 *	Removes previously installed NSLayoutConstraint
 */
- (void)uninstall;

@end


/**
 *  Convenience auto-boxing macros for MYMASConstraint methods.
 *
 *  Defining MYMAS_SHORTHAND_GLOBALS will turn on auto-boxing for default syntax.
 *  A potential drawback of this is that the unprefixed macros will appear in global scope.
 */
#define MYMAS_equalTo(...)                 equalTo(MYMASBoxValue((__VA_ARGS__)))
#define MYMAS_greaterThanOrEqualTo(...)    greaterThanOrEqualTo(MYMASBoxValue((__VA_ARGS__)))
#define MYMAS_lessThanOrEqualTo(...)       lessThanOrEqualTo(MYMASBoxValue((__VA_ARGS__)))

#define MYMAS_offset(...)                  valueOffset(MYMASBoxValue((__VA_ARGS__)))


#ifdef MYMAS_SHORTHAND_GLOBALS

#define equalTo(...)                     MYMAS_equalTo(__VA_ARGS__)
#define greaterThanOrEqualTo(...)        MYMAS_greaterThanOrEqualTo(__VA_ARGS__)
#define lessThanOrEqualTo(...)           MYMAS_lessThanOrEqualTo(__VA_ARGS__)

#define offset(...)                      MYMAS_offset(__VA_ARGS__)

#endif


@interface MYMASConstraint (AutoboxingSupport)

/**
 *  Aliases to corresponding relation methods (for shorthand macros)
 *  Also needed to aid autocompletion
 */
- (MYMASConstraint * (^)(id attr))MYMAS_equalTo;
- (MYMASConstraint * (^)(id attr))MYMAS_greaterThanOrEqualTo;
- (MYMASConstraint * (^)(id attr))MYMAS_lessThanOrEqualTo;

/**
 *  A dummy method to aid autocompletion
 */
- (MYMASConstraint * (^)(id offset))MYMAS_offset;

@end
