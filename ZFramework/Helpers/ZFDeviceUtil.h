//
//  ZFDeviceUtile.h
//  ZFramework
//
//  Created by 赵峰 on 16/2/15.
//  Copyright © 2016年 GInspire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFDeviceUtil : NSObject

//获取设备唯一标识
+ (NSString *)UUIDString;

//返回mac地址
+ (NSString *)macAddress;

//获取ip地址
+ (NSString *)ipAddress;

// 设备类型
+ (NSString *)deviceType;

//可用内存(单位MB)
+ (NSString *)availableMemory;

- (NSString *)idfaString;
- (NSString *)idfvString;

@end
