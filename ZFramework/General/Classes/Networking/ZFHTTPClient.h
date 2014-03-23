//
//  ZFHTTPClient.h
//  通过此HTTPClient调用的接口，数据通过CDN取回，因此数据可能是被缓存的数据，与用户相关的接口调用不要使用我。
//
//  Created by Yu Liang on 13-8-14.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface ZFHTTPClient : AFHTTPClient

+ (ZFHTTPClient *)sharedClient;

@end
