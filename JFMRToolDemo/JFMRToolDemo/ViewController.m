//
//  ViewController.m
//  JFMRToolDemo
//
//  Created by Criss on 2017/12/19.
//  Copyright © 2017年 SONG. All rights reserved.
//

#import "ViewController.h"
#import <JYangToolKit/JYangToolKit.h>

@interface ViewController ()

@end

@implementation ViewController
#pragma mark - ================================生命周期================================
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self customerSetting];
    
    [self addSubview];
    
}
#pragma mark - ================================公共方法================================

#pragma mark - ================================私有方法================================
- (void)customerSetting{
    
}
- (void)addSubview{
    UIView * redview = [[UIView alloc]init];
    redview.backgroundColor = [UIColor redColor];
    [self.view addSubview:redview];
    
//    [redview MYMAS_makeConstraints:^(MYMASConstraintMaker *make) {
//        make.left.MYMAS_equalTo(20);
//        make.width.MYMAS_equalTo(100);
//        make.top.MYMAS_equalTo(100);
//        make.height.MYMAS_equalTo(100);
//    }];
}

#pragma mark - ================================系统代理================================

#pragma mark - ================================自定义代理===============================

#pragma mark - ================================点击事件================================

#pragma mark - ================================网络请求================================

#pragma mark - ================================setter/getter=============================

@end
