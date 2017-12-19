//
//  NSArray+MYMASAdditions.m
//  
//
//  Created by Daniel Hammond on 11/26/13.
//
//

#import "NSArray+MYMASAdditions.h"
#import "View+MYMASAdditions.h"

@implementation NSArray (MYMASAdditions)

- (NSArray *)MYMAS_makeConstraints:(void(^)(MYMASConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (MYMAS_VIEW *view in self) {
        NSAssert([view isKindOfClass:[MYMAS_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view MYMAS_makeConstraints:block]];
    }
    return constraints;
}

- (NSArray *)MYMAS_updateConstraints:(void(^)(MYMASConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (MYMAS_VIEW *view in self) {
        NSAssert([view isKindOfClass:[MYMAS_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view MYMAS_updateConstraints:block]];
    }
    return constraints;
}

- (NSArray *)MYMAS_remakeConstraints:(void(^)(MYMASConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (MYMAS_VIEW *view in self) {
        NSAssert([view isKindOfClass:[MYMAS_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view MYMAS_remakeConstraints:block]];
    }
    return constraints;
}

- (void)MYMAS_distributeViewsAlongAxis:(MYMASAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    MYMAS_VIEW *tempSuperView = [self MYMAS_commonSuperviewOfViews];
    if (axisType == MYMASAxisTypeHorizontal) {
        MYMAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            MYMAS_VIEW *v = self[i];
            [v MYMAS_makeConstraints:^(MYMASConstraintMaker *make) {
                if (prev) {
                    make.width.equalTo(prev);
                    make.left.equalTo(prev.MYMAS_right).offset(fixedSpacing);
                    if (i == self.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                }
                else {//first one
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
    else {
        MYMAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            MYMAS_VIEW *v = self[i];
            [v MYMAS_makeConstraints:^(MYMASConstraintMaker *make) {
                if (prev) {
                    make.height.equalTo(prev);
                    make.top.equalTo(prev.MYMAS_bottom).offset(fixedSpacing);
                    if (i == self.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }                    
                }
                else {//first one
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
}

- (void)MYMAS_distributeViewsAlongAxis:(MYMASAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    MYMAS_VIEW *tempSuperView = [self MYMAS_commonSuperviewOfViews];
    if (axisType == MYMASAxisTypeHorizontal) {
        MYMAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            MYMAS_VIEW *v = self[i];
            [v MYMAS_makeConstraints:^(MYMASConstraintMaker *make) {
                make.width.equalTo(@(fixedItemLength));
                if (prev) {
                    if (i == self.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                        make.right.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {//first one
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
            }];
            prev = v;
        }
    }
    else {
        MYMAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            MYMAS_VIEW *v = self[i];
            [v MYMAS_makeConstraints:^(MYMASConstraintMaker *make) {
                make.height.equalTo(@(fixedItemLength));
                if (prev) {
                    if (i == self.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                        make.bottom.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {//first one
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
            }];
            prev = v;
        }
    }
}

- (MYMAS_VIEW *)MYMAS_commonSuperviewOfViews
{
    MYMAS_VIEW *commonSuperview = nil;
    MYMAS_VIEW *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[MYMAS_VIEW class]]) {
            MYMAS_VIEW *view = (MYMAS_VIEW *)object;
            if (previousView) {
                commonSuperview = [view MYMAS_closestCommonSuperview:commonSuperview];
            } else {
                commonSuperview = view;
            }
            previousView = view;
        }
    }
    NSAssert(commonSuperview, @"Can't constrain views that do not share a common superview. Make sure that all the views in this array have been added into the same view hierarchy.");
    return commonSuperview;
}

@end
