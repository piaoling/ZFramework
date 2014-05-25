//
//  ZFJsonModel.h
//  ZFramework
//
//  Created by zhaofeng on 14-5-10.
//  Copyright (c) 2014年 GInspire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFJsonModel : NSObject <NSCoding, NSCopying, NSMutableCopying>

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

//Http request callback blocks
typedef void (^VoidBlock)(void);
typedef void (^StringBlock)(NSString *info, NSError *error);
typedef void (^BoolBlock)(BOOL flag, NSError *error);
typedef void (^ModelBlock)(ZFJsonModel *model, NSError *error);
typedef void (^ArrayBlock)(NSMutableArray *models, NSError *error);
typedef void (^DictionaryBlock)(NSMutableDictionary *infoDict, NSError *error);
