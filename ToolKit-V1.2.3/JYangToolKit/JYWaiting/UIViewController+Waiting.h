//
//  UIViewController+Waiting.h
//  MyFramework
//
//  Created by 一路财富 on 16/5/11.
//  Copyright © 2016年 JYang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^completedBlock)(BOOL dismissed);

@interface UIViewController(Waiting)

- (void)showWaitInView:(nonnull UIView *)view hint:(nullable NSString *)hint;

- (void)hideWait;

- (void)showWait:(nullable NSString *)hint;

- (void)showWait:(nullable NSString *)hint completion:(nullable completedBlock)completion;

@end
