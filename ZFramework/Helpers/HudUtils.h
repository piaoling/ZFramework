//
//  HudUtils.h
//  TuNiuApp
//
//  Created by Yu Liang on 13-8-14.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface HudUtils : NSObject

+ (MBProgressHUD *)hudWithLabel:(NSString *)text inView:(UIView *)inView;
+ (MBProgressHUD *)hudWithTextOnly:(NSString *)text inView:(UIView *)inView delay:(NSInteger)delay;
+ (MBProgressHUD *)hudWithLabel:(NSString *)text customView:(UIView *)customView inView:(UIView *)inView delay:(NSInteger)delay;
+ (MBProgressHUD *)hudWithLabel:(NSString *)text detailText:(NSString *)detailText customView:(UIView *)customView inView:(UIView *)inView delay:(NSInteger)delay;

@end
