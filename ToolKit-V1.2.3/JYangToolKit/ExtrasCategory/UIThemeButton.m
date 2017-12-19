//
//  UIThemeButton.m
//  JrmfWalletKit
//
//  Created by 一路财富 on 16/10/31.
//  Copyright © 2016年 JYang. All rights reserved.
//

#import "UIThemeButton.h"
#import "JYangTools.h"

// 主体按钮规范
#define kButton_X           15.f
#define kButton_H           44.f

#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width

@implementation UIThemeButton

- (instancetype)initWithOri_Y:(float)Ori_Y WithThemeColor:(UIColor *)bgColor{
    self = [UIThemeButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        UIImage * bgImg = [JYangTools createImageWithColor:bgColor];
        self.frame = CGRectMake(kButton_X, Ori_Y, SCREEN_WIDTH-2*kButton_X, kButton_H);
        [self setBackgroundImage:bgImg forState:0];
        self.layer.cornerRadius = 4.f;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame WithThemeColor:(UIColor *)bgColor {
    self = [UIThemeButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        UIImage * bgImg = [JYangTools createImageWithColor:bgColor];
        self.frame = frame;
        [self setBackgroundImage:bgImg forState:0];
        self.layer.cornerRadius = 4.f;
        self.layer.masksToBounds = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
