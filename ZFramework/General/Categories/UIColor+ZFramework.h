//
//  UIColor+AppColor.h
//  YC
//
//  Created by Yu Liang on 13-8-13.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZFramework)

+ (UIColor*)appBackgroundColor;


+ (UIColor *)colorwithHexString:(NSString *)hexString;

/** Creates and returns a color object using the specific hex value.
 @param hex The hex value that will decide the color.
 @return The `UIColor` object.
 */
+ (UIColor *)colorWithHex:(unsigned int)hex;

/** Creates and returns a color object using the specific hex value.
 @param hex The hex value that will decide the color.
 @param alpha The opacity of the color.
 @return The `UIColor` object.
 */
+ (UIColor *)colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;

/** Creates and returns a color object with a random color value. The alpha property is 1.0.
 @return The `UIColor` object.
 */
+ (UIColor *)randomColor;

@end
