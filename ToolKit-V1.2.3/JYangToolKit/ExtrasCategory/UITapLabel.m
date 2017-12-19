//
//  UITapLabel.m
//  RedEnvelopeDemo
//
//  Created by 一路财富 on 16/2/27.
//  Copyright © 2016年 一路财富. All rights reserved.
//

#import "UITapLabel.h"

@interface UITapLabel () {
    CGPoint touchPoint;
}

@end

@implementation UITapLabel
@synthesize txtColor = _txtColor;
@synthesize enable = _enable;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.enable = YES;
        _txtColor = self.textColor;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.enable = YES;
        _txtColor = self.textColor;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    self.enable = YES;
    _txtColor = self.textColor;
    self.backgroundColor = [UIColor clearColor];
}

// 点击该label的时候, 来个高亮显示
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_enable)         return;
    
    UITouch *touch = [touches anyObject];
    touchPoint = [touch locationInView:self];
    [self setTextColor:[UIColor lightGrayColor]];
}

// 还原label颜色,获取手指离开屏幕时的坐标点, 在label范围内的话就可以触发自定义的操作
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_enable)         return;
    
    [self setTextColor:_txtColor];
    
    UITouch *touch = [touches anyObject];
    CGPoint points = [touch locationInView:self];
    
    if ((points.y - touchPoint.y) < 20) {
        [self.delegate tapLabel:self touchesWithTag:self.tag];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_enable)         return;
    
    [self setTextColor:_txtColor];
    [self.delegate tapLabel:self touchesWithTag:self.tag];
}

#pragma mark - set
- (void)setTxtColor:(UIColor *)txtColor {
    _txtColor = txtColor;
    self.textColor = txtColor;
}

- (void)setEnable:(BOOL)enable {
    _enable = enable;
}

@end
