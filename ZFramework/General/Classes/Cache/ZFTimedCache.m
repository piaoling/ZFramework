//
//  ZFTimedCache.m
//  ZFramework
//
//  Created by zhaofeng on 14-3-23.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import "ZFTimedCache.h"

@implementation ZFTimedCache

+ (id)sharedCache
{
    return nil;
}

- (id)objectForKey:(NSString *)key
{
    return [timedCache objectForKey:key];
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key
{
    [timedCache setObject:object forKey:key];
}

- (void)removeObjectForKey:(NSString *)key
{
    [timedCache removeObjectForKey:key];
}

- (void)removeAllObjects
{
    [timedCache removeAllObjects];
}

@end
