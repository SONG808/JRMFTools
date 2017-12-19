//
//  MYMASConstraint+Private.h
//  MYMASonry
//
//  Created by Nick Tymchenko on 29/04/14.
//  Copyright (c) 2014 cloudling. All rights reserved.
//

#import "MYMASConstraint.h"

@protocol MYMASConstraintDelegate;


@interface MYMASConstraint ()

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *	Usually MYMASConstraintMaker but could be a parent MYMASConstraint
 */
@property (nonatomic, weak) id<MYMASConstraintDelegate> delegate;

/**
 *  Based on a provided value type, is equal to calling:
 *  NSNumber - setOffset:
 *  NSValue with CGPoint - setPointOffset:
 *  NSValue with CGSize - setSizeOffset:
 *  NSValue with MYMASEdgeInsets - setInsets:
 */
- (void)setLayoutConstantWithValue:(NSValue *)value;

@end


@interface MYMASConstraint (Abstract)

/**
 *	Sets the constraint relation to given NSLayoutRelation
 *  returns a block which accepts one of the following:
 *    MYMASViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (MYMASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation;

/**
 *	Override to set a custom chaining behaviour
 */
- (MYMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end


@protocol MYMASConstraintDelegate <NSObject>

/**
 *	Notifies the delegate when the constraint needs to be replaced with another constraint. For example
 *  A MYMASViewConstraint may turn into a MYMASCompositeConstraint when an array is passed to one of the equality blocks
 */
- (void)constraint:(MYMASConstraint *)constraint shouldBeReplacedWithConstraint:(MYMASConstraint *)replacementConstraint;

- (MYMASConstraint *)constraint:(MYMASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end
