//
//  ZFAutoLabel.h
//  ZFramework
//
//  Created by zhaofeng on 14-4-22.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import<Foundation/Foundation.h>
#import<UIKit/UIKit.h>

@interface ZFAutoLabel : UILabel

@property(nonatomic,assign) CGFloat characterSpacing;
@property(nonatomic,assign) CGFloat    linesSpacing;


- (void)autoResetHeightByWidth:(CGFloat)width text:(NSString *)text lineSpace:(CGFloat)lineSpace font:(UIFont *)font textColor:(UIColor *)color;

- (CGFloat)getAutoResetHeightByWidth:(CGFloat)width text:(NSString *)text font:(UIFont *)font lineSpace:(CGFloat)lineSpace;

- (void)autoResetHeightByWidth:(CGFloat)width lineSpace:(CGFloat)lineSpace;


@end
