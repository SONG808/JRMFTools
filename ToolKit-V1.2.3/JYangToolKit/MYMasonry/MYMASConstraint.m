//
//  MYMASConstraint.m
//  MYMASonry
//
//  Created by Nick Tymchenko on 1/20/14.
//

#import "MYMASConstraint.h"
#import "MYMASConstraint+Private.h"

#define MYMASMethodNotImplemented() \
    @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
                                 userInfo:nil]

@implementation MYMASConstraint

#pragma mark - Init

- (id)init {
	NSAssert(![self isMemberOfClass:[MYMASConstraint class]], @"MYMASConstraint is an abstract class, you should not instantiate it directly.");
	return [super init];
}

#pragma mark - NSLayoutRelation proxies

- (MYMASConstraint * (^)(id))equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}

- (MYMASConstraint * (^)(id))MYMAS_equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}

- (MYMASConstraint * (^)(id))greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (MYMASConstraint * (^)(id))MYMAS_greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (MYMASConstraint * (^)(id))lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}

- (MYMASConstraint * (^)(id))MYMAS_lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}

#pragma mark - MYMASLayoutPriority proxies

- (MYMASConstraint * (^)(void))priorityLow {
    return ^id{
        self.priority(MYMASLayoutPriorityDefaultLow);
        return self;
    };
}

- (MYMASConstraint * (^)(void))priorityMedium {
    return ^id{
        self.priority(MYMASLayoutPriorityDefaultMedium);
        return self;
    };
}

- (MYMASConstraint * (^)(void))priorityHigh {
    return ^id{
        self.priority(MYMASLayoutPriorityDefaultHigh);
        return self;
    };
}

#pragma mark - NSLayoutConstraint constant proxies

- (MYMASConstraint * (^)(MYMASEdgeInsets))insets {
    return ^id(MYMASEdgeInsets insets){
        self.insets = insets;
        return self;
    };
}

- (MYMASConstraint * (^)(CGFloat))inset {
    return ^id(CGFloat inset){
        self.inset = inset;
        return self;
    };
}

- (MYMASConstraint * (^)(CGSize))sizeOffset {
    return ^id(CGSize offset) {
        self.sizeOffset = offset;
        return self;
    };
}

- (MYMASConstraint * (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        self.centerOffset = offset;
        return self;
    };
}

- (MYMASConstraint * (^)(CGFloat))offset {
    return ^id(CGFloat offset){
        self.offset = offset;
        return self;
    };
}

- (MYMASConstraint * (^)(NSValue *value))valueOffset {
    return ^id(NSValue *offset) {
        NSAssert([offset isKindOfClass:NSValue.class], @"expected an NSValue offset, got: %@", offset);
        [self setLayoutConstantWithValue:offset];
        return self;
    };
}

- (MYMASConstraint * (^)(id offset))MYMAS_offset {
    // Will never be called due to macro
    return nil;
}

#pragma mark - NSLayoutConstraint constant setter

- (void)setLayoutConstantWithValue:(NSValue *)value {
    if ([value isKindOfClass:NSNumber.class]) {
        self.offset = [(NSNumber *)value doubleValue];
    } else if (strcmp(value.objCType, @encode(CGPoint)) == 0) {
        CGPoint point;
        [value getValue:&point];
        self.centerOffset = point;
    } else if (strcmp(value.objCType, @encode(CGSize)) == 0) {
        CGSize size;
        [value getValue:&size];
        self.sizeOffset = size;
    } else if (strcmp(value.objCType, @encode(MYMASEdgeInsets)) == 0) {
        MYMASEdgeInsets insets;
        [value getValue:&insets];
        self.insets = insets;
    } else {
        NSAssert(NO, @"attempting to set layout constant with unsupported value: %@", value);
    }
}

#pragma mark - Semantic properties

- (MYMASConstraint *)with {
    return self;
}

- (MYMASConstraint *)and {
    return self;
}

#pragma mark - Chaining

- (MYMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute __unused)layoutAttribute {
    MYMASMethodNotImplemented();
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

#pragma mark - Abstract

- (MYMASConstraint * (^)(CGFloat multiplier))multipliedBy { MYMASMethodNotImplemented(); }

- (MYMASConstraint * (^)(CGFloat divider))dividedBy { MYMASMethodNotImplemented(); }

- (MYMASConstraint * (^)(MYMASLayoutPriority priority))priority { MYMASMethodNotImplemented(); }

- (MYMASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation { MYMASMethodNotImplemented(); }

- (MYMASConstraint * (^)(id key))key { MYMASMethodNotImplemented(); }

- (void)setInsets:(MYMASEdgeInsets __unused)insets { MYMASMethodNotImplemented(); }

- (void)setInset:(CGFloat __unused)inset { MYMASMethodNotImplemented(); }

- (void)setSizeOffset:(CGSize __unused)sizeOffset { MYMASMethodNotImplemented(); }

- (void)setCenterOffset:(CGPoint __unused)centerOffset { MYMASMethodNotImplemented(); }

- (void)setOffset:(CGFloat __unused)offset { MYMASMethodNotImplemented(); }

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)

- (MYMASConstraint *)animator { MYMASMethodNotImplemented(); }

#endif

- (void)activate { MYMASMethodNotImplemented(); }

- (void)deactivate { MYMASMethodNotImplemented(); }

- (void)install { MYMASMethodNotImplemented(); }

- (void)uninstall { MYMASMethodNotImplemented(); }

@end
