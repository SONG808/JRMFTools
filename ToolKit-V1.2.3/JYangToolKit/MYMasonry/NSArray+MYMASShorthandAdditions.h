//
//  NSArray+MYMASShorthandAdditions.h
//  MYMASonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "NSArray+MYMASAdditions.h"

#ifdef MYMAS_SHORTHAND

/**
 *	Shorthand array additions without the 'MYMAS_' prefixes,
 *  only enabled if MYMAS_SHORTHAND is defined
 */
@interface NSArray (MYMASShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(MYMASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(MYMASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(MYMASConstraintMaker *make))block;

@end

@implementation NSArray (MYMASShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(MYMASConstraintMaker *))block {
    return [self MYMAS_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(^)(MYMASConstraintMaker *))block {
    return [self MYMAS_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(^)(MYMASConstraintMaker *))block {
    return [self MYMAS_remakeConstraints:block];
}

@end

#endif
