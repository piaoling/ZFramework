//
//  ZFImageCache.m
//  ZFramework
//
//  Created by zhaofeng on 14-3-23.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import "ZFImageCache.h"

#define kTNImageCacheDictionarySuffix @"ImageCache"

static TMCache *imageCache = nil;

@implementation ZFImageCache

+ (id)sharedCache
{
    if (!imageCache) {
        imageCache = [[TMCache alloc] initWithName:kTNImageCacheDictionarySuffix];
    }
    
    return imageCache;
}

- (id)objectForKey:(NSString *)key
{
    return [imageCache objectForKey:key];
}

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key
{
    [imageCache setObject:object forKey:key];
}

- (void)removeObjectForKey:(NSString *)key
{
    [imageCache removeObjectForKey:key];
}

- (void)removeAllObjects
{
    [imageCache removeAllObjects];
}

@end
