//
//  ZFTimedCache.h
//  ZFramework
//
//  Created by zhaofeng on 14-3-23.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import "ZFCache.h"

typedef NS_ENUM(long long, ZFTimedCacheAgeLimit) {
    ZFTimedCacheAgeLimitThreeDays = 259200, //缓存秒数，3*24*60*60
    ZFTimedCacheAgeLimitSevenDays = 604800, //缓存秒数，7*24*60*60
    ZFTimedCacheAgeLimitForeverDays = 3153600000//缓存描述，100年 100 * 365 * 24 * 60 * 60
};

#define kTNPermanentCacheDictionarySuffix @"TimedCache"

static TMCache *timedCache = nil;

@interface ZFTimedCache : ZFCache

+ (id)sharedCache;

@end
