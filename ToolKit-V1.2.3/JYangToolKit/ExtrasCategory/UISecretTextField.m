//
//  UISecretTextField.m
//  RedEnvelopeDemo
//
//  Created by 一路财富 on 16/3/31.
//  Copyright © 2016年 一路财富. All rights reserved.
//

#import "UISecretTextField.h"

@implementation UISecretTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if ([UIMenuController sharedMenuController]) {
        
        [UIMenuController sharedMenuController].menuVisible = NO;
        
    }
    
    return NO;
}

@end
