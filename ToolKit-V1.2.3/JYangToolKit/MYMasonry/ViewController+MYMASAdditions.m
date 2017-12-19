//
//  UIViewController+MYMASAdditions.m
//  MYMASonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "ViewController+MYMASAdditions.h"

#ifdef MYMAS_VIEW_CONTROLLER

@implementation MYMAS_VIEW_CONTROLLER (MYMASAdditions)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (MYMASViewAttribute *)MYMAS_topLayoutGuide {
    return [[MYMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (MYMASViewAttribute *)MYMAS_topLayoutGuideTop {
    return [[MYMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (MYMASViewAttribute *)MYMAS_topLayoutGuideBottom {
    return [[MYMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (MYMASViewAttribute *)MYMAS_bottomLayoutGuide {
    return [[MYMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (MYMASViewAttribute *)MYMAS_bottomLayoutGuideTop {
    return [[MYMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (MYMASViewAttribute *)MYMAS_bottomLayoutGuideBottom {
    return [[MYMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

#pragma clang diagnostic pop

@end

#endif
