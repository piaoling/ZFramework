//
//  UILabel+ZFramework.h
//  ZFramework
//
//  Created by zhaofeng on 14-1-18.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(ZFramework)
//auto reset uilabel's width;自动这是UILabel的宽度
- (void)autoSetWidth;
- (void)autoSetWidthByHeight:(CGFloat)height;
- (void)autoSetWidthByHeight:(CGFloat)height minWidth:(CGFloat)minWidth;

- (void)autoSetHeight;
- (void)autoSetHeightByWidth:(CGFloat)width;
- (void)autoSetHeightByWidth:(CGFloat)width minHeight:(CGFloat)minHeight;

- (CGFloat)calculateHeightByWidth:(CGFloat)width text:(NSString *)text;
@end
