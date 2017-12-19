//
//  UIViewController+MYMASAdditions.h
//  MYMASonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "MYMASUtilities.h"
#import "MYMASConstraintMaker.h"
#import "MYMASViewAttribute.h"

#ifdef MYMAS_VIEW_CONTROLLER

@interface MYMAS_VIEW_CONTROLLER (MYMASAdditions)

/**
 *	following properties return a new MYMASViewAttribute with appropriate UILayoutGuide and NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_topLayoutGuide NS_DEPRECATED_IOS(8.0, 11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_bottomLayoutGuide NS_DEPRECATED_IOS(8.0, 11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_topLayoutGuideTop NS_DEPRECATED_IOS(8.0, 11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_topLayoutGuideBottom NS_DEPRECATED_IOS(8.0, 11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_bottomLayoutGuideTop NS_DEPRECATED_IOS(8.0, 11.0);
@property (nonatomic, strong, readonly) MYMASViewAttribute *MYMAS_bottomLayoutGuideBottom NS_DEPRECATED_IOS(8.0, 11.0);

@end

#endif
