//
//  UIColor+AppColor.m
//  YC
//
//  Created by Yu Liang on 13-8-13.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import "UIColor+ZFramework.h"


#define GREY(color) [UIColor colorWithRed:color/255.0 green:color/255.0 blue:color/255.0 alpha:1]

@implementation UIColor (AppColor)

+ (UIColor*)appBackgroundColor {
    
    return [UIColor colorwithHexString:@"#fefefc"];
}

+ (UIColor *)colorwithHexString:(NSString *)hexString
{
    unsigned int hex = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&hex];
    return [UIColor colorWithHex:hex];
}

+ (id)colorWithHex:(unsigned int)hex{
	return [UIColor colorWithHex:hex alpha:1];
}

+ (id)colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha{
	
	return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hex & 0xFF)) / 255.0
                           alpha:alpha];
	
}

+ (UIColor*) randomColor{
	
	NSInteger r = arc4random() % 255;
	NSInteger g = arc4random() % 255;
	NSInteger b = arc4random() % 255;
	return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
	
}

@end
