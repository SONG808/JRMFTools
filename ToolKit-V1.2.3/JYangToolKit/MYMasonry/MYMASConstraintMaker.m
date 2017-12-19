//
//  MYMASConstraintMaker.m
//  MYMASonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MYMASConstraintMaker.h"
#import "MYMASViewConstraint.h"
#import "MYMASCompositeConstraint.h"
#import "MYMASConstraint+Private.h"
#import "MYMASViewAttribute.h"
#import "View+MYMASAdditions.h"

@interface MYMASConstraintMaker () <MYMASConstraintDelegate>

@property (nonatomic, weak) MYMAS_VIEW *view;
@property (nonatomic, strong) NSMutableArray *constraints;

@end

@implementation MYMASConstraintMaker

- (id)initWithView:(MYMAS_VIEW *)view {
    self = [super init];
    if (!self) return nil;
    
    self.view = view;
    self.constraints = NSMutableArray.new;
    
    return self;
}

- (NSArray *)install {
    if (self.removeExisting) {
        NSArray *installedConstraints = [MYMASViewConstraint installedConstraintsForView:self.view];
        for (MYMASConstraint *constraint in installedConstraints) {
            [constraint uninstall];
        }
    }
    NSArray *constraints = self.constraints.copy;
    for (MYMASConstraint *constraint in constraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
    [self.constraints removeAllObjects];
    return constraints;
}

#pragma mark - MYMASConstraintDelegate

- (void)constraint:(MYMASConstraint *)constraint shouldBeReplacedWithConstraint:(MYMASConstraint *)replacementConstraint {
    NSUInteger index = [self.constraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.constraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (MYMASConstraint *)constraint:(MYMASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    MYMASViewAttribute *viewAttribute = [[MYMASViewAttribute alloc] initWithView:self.view layoutAttribute:layoutAttribute];
    MYMASViewConstraint *newConstraint = [[MYMASViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    if ([constraint isKindOfClass:MYMASViewConstraint.class]) {
        //replace with composite constraint
        NSArray *children = @[constraint, newConstraint];
        MYMASCompositeConstraint *compositeConstraint = [[MYMASCompositeConstraint alloc] initWithChildren:children];
        compositeConstraint.delegate = self;
        [self constraint:constraint shouldBeReplacedWithConstraint:compositeConstraint];
        return compositeConstraint;
    }
    if (!constraint) {
        newConstraint.delegate = self;
        [self.constraints addObject:newConstraint];
    }
    return newConstraint;
}

- (MYMASConstraint *)addConstraintWithAttributes:(MYMASAttribute)attrs {
    __unused MYMASAttribute anyAttribute = (MYMASAttributeLeft | MYMASAttributeRight | MYMASAttributeTop | MYMASAttributeBottom | MYMASAttributeLeading
                                          | MYMASAttributeTrailing | MYMASAttributeWidth | MYMASAttributeHeight | MYMASAttributeCenterX
                                          | MYMASAttributeCenterY | MYMASAttributeBaseline
                                          | MYMASAttributeFirstBaseline | MYMASAttributeLastBaseline
#if TARGET_OS_IPHONE || TARGET_OS_TV
                                          | MYMASAttributeLeftMargin | MYMASAttributeRightMargin | MYMASAttributeTopMargin | MYMASAttributeBottomMargin
                                          | MYMASAttributeLeadingMargin | MYMASAttributeTrailingMargin | MYMASAttributeCenterXWithinMargins
                                          | MYMASAttributeCenterYWithinMargins
#endif
                                          );
    
    NSAssert((attrs & anyAttribute) != 0, @"You didn't pass any attribute to make.attributes(...)");
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    if (attrs & MYMASAttributeLeft) [attributes addObject:self.view.MYMAS_left];
    if (attrs & MYMASAttributeRight) [attributes addObject:self.view.MYMAS_right];
    if (attrs & MYMASAttributeTop) [attributes addObject:self.view.MYMAS_top];
    if (attrs & MYMASAttributeBottom) [attributes addObject:self.view.MYMAS_bottom];
    if (attrs & MYMASAttributeLeading) [attributes addObject:self.view.MYMAS_leading];
    if (attrs & MYMASAttributeTrailing) [attributes addObject:self.view.MYMAS_trailing];
    if (attrs & MYMASAttributeWidth) [attributes addObject:self.view.MYMAS_width];
    if (attrs & MYMASAttributeHeight) [attributes addObject:self.view.MYMAS_height];
    if (attrs & MYMASAttributeCenterX) [attributes addObject:self.view.MYMAS_centerX];
    if (attrs & MYMASAttributeCenterY) [attributes addObject:self.view.MYMAS_centerY];
    if (attrs & MYMASAttributeBaseline) [attributes addObject:self.view.MYMAS_baseline];
    if (attrs & MYMASAttributeFirstBaseline) [attributes addObject:self.view.MYMAS_firstBaseline];
    if (attrs & MYMASAttributeLastBaseline) [attributes addObject:self.view.MYMAS_lastBaseline];
    
#if TARGET_OS_IPHONE || TARGET_OS_TV
    
    if (attrs & MYMASAttributeLeftMargin) [attributes addObject:self.view.MYMAS_leftMargin];
    if (attrs & MYMASAttributeRightMargin) [attributes addObject:self.view.MYMAS_rightMargin];
    if (attrs & MYMASAttributeTopMargin) [attributes addObject:self.view.MYMAS_topMargin];
    if (attrs & MYMASAttributeBottomMargin) [attributes addObject:self.view.MYMAS_bottomMargin];
    if (attrs & MYMASAttributeLeadingMargin) [attributes addObject:self.view.MYMAS_leadingMargin];
    if (attrs & MYMASAttributeTrailingMargin) [attributes addObject:self.view.MYMAS_trailingMargin];
    if (attrs & MYMASAttributeCenterXWithinMargins) [attributes addObject:self.view.MYMAS_centerXWithinMargins];
    if (attrs & MYMASAttributeCenterYWithinMargins) [attributes addObject:self.view.MYMAS_centerYWithinMargins];
    
#endif
    
    NSMutableArray *children = [NSMutableArray arrayWithCapacity:attributes.count];
    
    for (MYMASViewAttribute *a in attributes) {
        [children addObject:[[MYMASViewConstraint alloc] initWithFirstViewAttribute:a]];
    }
    
    MYMASCompositeConstraint *constraint = [[MYMASCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

#pragma mark - standard Attributes

- (MYMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    return [self constraint:nil addConstraintWithLayoutAttribute:layoutAttribute];
}

- (MYMASConstraint *)left {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeft];
}

- (MYMASConstraint *)top {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTop];
}

- (MYMASConstraint *)right {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRight];
}

- (MYMASConstraint *)bottom {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottom];
}

- (MYMASConstraint *)leading {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeading];
}

- (MYMASConstraint *)trailing {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailing];
}

- (MYMASConstraint *)width {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth];
}

- (MYMASConstraint *)height {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight];
}

- (MYMASConstraint *)centerX {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}

- (MYMASConstraint *)centerY {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}

- (MYMASConstraint *)baseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBaseline];
}

- (MYMASConstraint *(^)(MYMASAttribute))attributes {
    return ^(MYMASAttribute attrs){
        return [self addConstraintWithAttributes:attrs];
    };
}

- (MYMASConstraint *)firstBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeFirstBaseline];
}

- (MYMASConstraint *)lastBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLastBaseline];
}

#if TARGET_OS_IPHONE || TARGET_OS_TV

- (MYMASConstraint *)leftMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeftMargin];
}

- (MYMASConstraint *)rightMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRightMargin];
}

- (MYMASConstraint *)topMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTopMargin];
}

- (MYMASConstraint *)bottomMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottomMargin];
}

- (MYMASConstraint *)leadingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (MYMASConstraint *)trailingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (MYMASConstraint *)centerXWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (MYMASConstraint *)centerYWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif


#pragma mark - composite Attributes

- (MYMASConstraint *)edges {
    return [self addConstraintWithAttributes:MYMASAttributeTop | MYMASAttributeLeft | MYMASAttributeRight | MYMASAttributeBottom];
}

- (MYMASConstraint *)size {
    return [self addConstraintWithAttributes:MYMASAttributeWidth | MYMASAttributeHeight];
}

- (MYMASConstraint *)center {
    return [self addConstraintWithAttributes:MYMASAttributeCenterX | MYMASAttributeCenterY];
}

#pragma mark - grouping

- (MYMASConstraint *(^)(dispatch_block_t group))group {
    return ^id(dispatch_block_t group) {
        NSInteger previousCount = self.constraints.count;
        group();

        NSArray *children = [self.constraints subarrayWithRange:NSMakeRange(previousCount, self.constraints.count - previousCount)];
        MYMASCompositeConstraint *constraint = [[MYMASCompositeConstraint alloc] initWithChildren:children];
        constraint.delegate = self;
        return constraint;
    };
}

@end
