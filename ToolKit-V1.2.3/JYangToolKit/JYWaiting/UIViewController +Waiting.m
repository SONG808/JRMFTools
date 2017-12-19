//
//  UIViewController+Waiting.m
//  MyFramework
//
//  Created by 一路财富 on 16/5/11.
//  Copyright © 2016年 JYang. All rights reserved.
//

#import "UIViewController+Waiting.h"
#import "JYWaiting.h"
#import <objc/runtime.h>

@interface UIViewController (Waiting_Private)

@property (nonatomic, strong) JYWaiting *progressHud;
@property (copy, nonatomic) completedBlock JYCompletion;

@end

@implementation UIViewController(Waiting)

const char *kWaitKey = "JYProgressHUD_Key";
const char *kCompletedKey = "JYCompeted_key";

- (void)showWaitInView:(UIView *)view hint:(NSString *)hint {
    [self showHudWithMessage:hint model:JYWaitingModeIndeterminate];
}

- (void)hideWait {
    [self.progressHud hideAnimated:YES];
    self.progressHud = nil;
    if (self.JYCompletion) {
        self.JYCompletion(YES);
    }
}

- (void)showWait:(NSString *)hint {
    [self showHudWithMessage:hint model:JYWaitingModeText];
    [self performSelector:@selector(hideWait) withObject:nil afterDelay:2.f];
}

- (void)showWait:(NSString *)hint completion:(completedBlock)completion{
    self.JYCompletion = completion;
    [self showWait:hint];
}


#pragma mark - Private
- (void)showHudWithMessage:(NSString *)message model:(JYWaitingMode)mode {
    self.progressHud.mode = mode ?: JYWaitingModeIndeterminate;
    self.progressHud.label.text = message;
    self.progressHud.label.font = [UIFont systemFontOfSize:15];
    [self.progressHud showAnimated:YES];
}

- (void)hideHudWithMessage:(NSString *)message image:(UIImage *)image {
    self.progressHud.customView = [[UIImageView alloc] initWithImage:image];
    self.progressHud.mode = JYWaitingModeCustomView;
    self.progressHud.label.text = message;
    self.progressHud.label.font = [UIFont systemFontOfSize:15];
    
    [self.progressHud showAnimated:YES];
    [self performSelector:@selector(hideWait) withObject:nil afterDelay:0.7];
}

#pragma mark - setter & getter
- (void)setProgressHud:(JYWaiting *)progressHud {
    objc_setAssociatedObject(self, kWaitKey, progressHud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setJYCompletion:(completedBlock)JYCompletion {

    objc_setAssociatedObject(self, kCompletedKey, JYCompletion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (completedBlock)JYCompletion {
    return objc_getAssociatedObject(self, kCompletedKey);
}

- (JYWaiting *)progressHud {
    JYWaiting *hud = objc_getAssociatedObject(self, kWaitKey);
    if (!hud) {
        UIView *hudSuperView = self.view;
        hud = [[JYWaiting alloc] initWithView:hudSuperView];
        hud.removeFromSuperViewOnHide = YES;
        [hudSuperView addSubview:hud];
        self.progressHud = hud;
    }
    return hud;
}


@end
