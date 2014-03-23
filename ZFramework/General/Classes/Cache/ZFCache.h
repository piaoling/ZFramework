//
//  ZFCache.h
//  ZFramework
//
//  Created by zhaofeng on 14-3-23.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import "TMCache.h"

@interface ZFCache : NSObject

+ (id)sharedCache;

- (id)objectForKey:(NSString *)key;

- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;

- (void)removeAllObjects;

@end
