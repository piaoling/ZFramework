//
//  ZFSevenDaysCache.m
//  ZFramework
//
//  Created by zhaofeng on 14-3-23.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import "ZFSevenDaysCache.h"

@implementation ZFSevenDaysCache

+ (id)sharedCache
{
    //    if (!timedCache) {
    timedCache = [[TMCache alloc] initWithName:[kTNPermanentCacheDictionarySuffix stringByAppendingString:@"SevenDays"]];
    timedCache.diskCache.ageLimit = ZFTimedCacheAgeLimitSevenDays;
    //    }
    
    return timedCache;
}

@end
