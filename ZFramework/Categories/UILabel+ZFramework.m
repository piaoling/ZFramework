//
//  UILabel+ZFramework.m
//  ZFramework
//
//  Created by zhaofeng on 14-1-18.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import "UILabel+ZFramework.h"

@implementation UILabel (ZFramework)

- (void)autoSetWidth
{
    [self autoSetWidthByHeight:self.frame.size.height];
}

- (void)autoSetWidthByHeight:(CGFloat)height
{
    [self autoSetWidthByHeight:height minWidth:0.0f];
}

- (void)autoSetWidthByHeight:(CGFloat)height minWidth:(CGFloat)minWidth
{
    self.lineBreakMode = UILineBreakModeCharacterWrap;
    CGSize size = CGSizeMake(320,height);
    NSString * textString = self.text;
    CGSize labelsize = [textString sizeWithFont:self.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    if (labelsize.width < minWidth) {
        labelsize.width = minWidth;
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, labelsize.width, self.frame.size.height );
}

- (void)autoSetHeight
{
    [self autoSetHeightByWidth:self.frame.size.width];
}

- (void)autoSetHeightByWidth:(CGFloat)width
{
    [self autoSetHeightByWidth:width minHeight:0.0f];
}

- (void)autoSetHeightByWidth:(CGFloat)width minHeight:(CGFloat)minHeight
{
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByCharWrapping;
    NSString *textString = self.text;
    CGSize size = [textString sizeWithFont:self.font                            constrainedToSize:CGSizeMake(width, MAXFLOAT)
                       lineBreakMode:NSLineBreakByCharWrapping];
    size.height += 3;
    if (size.height < minHeight + 3) {
        size.height = minHeight;
    }
    
    CGRect frame = self.frame;
    frame.size.height = size.height;
    self.frame = frame;
}

- (CGFloat)calculateHeightByWidth:(CGFloat)width text:(NSString *)text
{
    [self sizeToFit];
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [text sizeWithFont:self.font                            constrainedToSize:CGSizeMake(width, MAXFLOAT)
                       lineBreakMode:NSLineBreakByCharWrapping];
    
    return size.height;
}


@end
