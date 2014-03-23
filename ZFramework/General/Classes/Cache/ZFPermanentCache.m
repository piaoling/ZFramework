//
//  ZFPermanentCache.m
//  ZFramework
//
//  Created by zhaofeng on 14-3-23.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import "ZFPermanentCache.h"

#define kTNPermanentCacheDictionarySuffix @"PermanentCache"

static TMCache *permanentCache = nil;

@implementation ZFPermanentCache

+ (id)sharedCache
{
    if (!permanentCache) {
        permanentCache = [[TMCache alloc] initWithName:kTNPermanentCacheDictionarySuffix];
    }
    
    return permanentCache;
}

- (id)objectForKey:(NSString *)key
{
    return [permanentCache objectForKey:key];
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key
{
    [permanentCache setObject:object forKey:key];
}

- (void)removeObjectForKey:(NSString *)key
{
    [permanentCache removeObjectForKey:key];
}

- (void)removeAllObjects
{
    [permanentCache removeAllObjects];
}

@end
