//
//  NSDictionary+MutableDeepCopy.m
//  GlucoseGuard
//
//  Created by wangyang on 13-6-25.
//  Copyright (c) 2013年 wangyang. All rights reserved.
//

#import "NSDictionary+MutableDeepCopy.h"

@implementation NSDictionary (MutableDeepCopy)
-(NSMutableDictionary *)zf_mutableDeepCopy
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:[self count]];
    //新建一个NSMutableDictionary对象，大小为原NSDictionary对象的大小
    NSArray *keys=[self allKeys];
    for(id key in keys)
    {//循环读取复制每一个元素
        id curValue=[self objectForKey:key];
        id copyValue;
        if ([curValue respondsToSelector:@selector(zf_mutableDeepCopy)]) {
            //如果key对应的元素可以响应mutableDeepCopy方法(还是NSDictionary)，调用mutableDeepCopy方法复制
            copyValue=[curValue zf_mutableDeepCopy];
        }
        else if([curValue respondsToSelector:@selector(mutableCopy)])
        {
            copyValue=[curValue mutableCopy];
        }
        if(copyValue==nil)
            copyValue=[curValue copy];
        [dict setObject:copyValue forKey:key];
        
    }
    return dict;
}
@end
