//
//  YCHTTPClient.m
//  YC
//
//  Created by Yu Liang on 13-8-14.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import "ZFHTTPClient.h"
#import "ZFBase64JSONRequestOperation.h"
#import "JSONKit.h"
#import "Base64.h"

@implementation ZFHTTPClient

+ (ZFHTTPClient *)sharedClient
{
    static ZFHTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ZFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:API_BASE_URL_STRING]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[ZFBase64JSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"text/html"];
    
    // By default, the example ships with SSL pinning enabled for the app.net API pinned against the public key of adn.cer file included with the example. In order to make it easier for developers who are new to AFNetworking, SSL pinning is automatically disabled if the base URL has been changed. This will allow developers to hack around with the example, without getting tripped up by SSL pinning.
//    if ([[url scheme] isEqualToString:@"https"] && [[url host] isEqualToString:@"alpha-api.app.net"]) {
//        self.defaultSSLPinningMode = AFSSLPinningModePublicKey;
//    } else {
//        self.defaultSSLPinningMode = AFSSLPinningModeNone;
//    }
    
    return self;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters
{
    //NSLog(@"%@",[parameters JSONString]);
    NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:nil];
    
    if (parameters) {
        if ([method isEqualToString:@"GET"] || [method isEqualToString:@"HEAD"] || [method isEqualToString:@"DELETE"]) {
            NSString *paramString = [[parameters JSONString] zf_base64EncodedString];
            NSURL *url = request.URL;
//            url = [NSURL URLWithString:[[url absoluteString] stringByAppendingFormat:[path rangeOfString:@"?"].location == NSNotFound ? @"?%@" : @"&%@", paramString]];
            url = [NSURL URLWithString:[[url absoluteString] stringByAppendingFormat:@"/%@", paramString]];
            [request setURL:url];
        } else {
            NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.stringEncoding));
            
            [request setValue:[NSString stringWithFormat:@"text/html; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
            
            NSString *postString = [parameters JSONString]; //json encode
            postString = [postString zf_base64EncodedString]; //base64 encode
            NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:postData];
        }
    }
    
    return request;
}

@end
