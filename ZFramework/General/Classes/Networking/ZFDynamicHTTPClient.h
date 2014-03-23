//
//  ZFDynamicHTTPClient.h
//  通过此HTTPClient调用的接口，数据不通过CDN取回，因此数据均是实时的数据，与用户相关的接口调用请使用我。
//
//  Created by finder on 13-11-5.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface ZFDynamicHTTPClient : AFHTTPClient

+ (ZFDynamicHTTPClient *)sharedClient;
- (void)postFormData:(NSData*)data name:(NSString*)name fileName:(NSString*)fileName parameters:(NSDictionary*)param Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
