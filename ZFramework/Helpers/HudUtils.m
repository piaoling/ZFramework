//
//  HudUtils.m
//  TuNiuApp
//
//  Created by Yu Liang on 13-8-14.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import "HudUtils.h"

@implementation HudUtils

+ (MBProgressHUD *)hudWithLabel:(NSString *)text inView:(UIView *)inView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:inView animated:YES];
    if (text) {
        hud.labelText = text;
    } else {
        hud.labelText = @"加载中...";
    }
	
	hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (MBProgressHUD *)hudWithTextOnly:(NSString *)text inView:(UIView *)inView delay:(NSInteger)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:inView animated:YES];
	
	hud.mode = MBProgressHUDModeText;
	hud.labelText = text;
	hud.margin = 10.f;
	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
	if (delay > 0) {
        [hud hide:YES afterDelay:delay];
    } else {
        [hud hide:YES afterDelay:3];
    }
    return hud;
}

+ (MBProgressHUD *)hudWithLabel:(NSString *)text customView:(UIView *)customView inView:(UIView *)inView delay:(NSInteger)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:inView animated:YES];
	
    if (customView) {
        hud.customView = customView;
    } else {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_mark"]];
    }
    
	hud.labelText = text;
	// Set custom view mode
	hud.mode = MBProgressHUDModeCustomView;
	hud.removeFromSuperViewOnHide = YES;
    
    if (delay > 0) {
        [hud hide:YES afterDelay:delay];
    }
	return hud;
}

+ (MBProgressHUD *)hudWithLabel:(NSString *)text detailText:(NSString *)detailText customView:(UIView *)customView inView:(UIView *)inView delay:(NSInteger)delay
{
    MBProgressHUD *hud = [self hudWithLabel:text customView:customView inView:inView delay:delay];
    hud.detailsLabelText = detailText;
    return hud;
}

@end
