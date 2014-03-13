//
//  DimensionMacro.h
//  ZFramework
//
//  Created by zhaofeng on 14-1-19.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#ifndef ZFramework_DimensionMacro_h
#define ZFramework_DimensionMacro_h

#define TIP_DELAY_IN_SECOND                         2                     //tip显示时间

//状态栏高度
#define STATUS_BAR_HEIGHT 20
//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44
//TabBar高度
#define TAB_BAR_HEIGHT 49
//屏幕 rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define FULL_VIEW_HEIGHT (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)?(SCREEN_HEIGHT):(SCREEN_HEIGHT- 20))

//屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

#endif
