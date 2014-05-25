//
//  ZFDynamicHTTPClient.m
//  TuNiuApp
//
//  Created by finder on 13-11-5.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import "ZFDynamicHTTPClient.h"
#import "ZFBase64JSONRequestOperation.h"
#import "JSONKit.h"
#import "Base64.h"

@implementation ZFDynamicHTTPClient

+ (ZFDynamicHTTPClient *)sharedClient
{
    static ZFDynamicHTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ZFDynamicHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:API_BASE_URL_STRING]];
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
    [request setTimeoutInterval:600];
    
    if (parameters) {
        
        //参数添加时间戳
        NSMutableDictionary *tmpParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
        tmpParameters[@"r"] = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
        parameters = [NSDictionary dictionaryWithDictionary:tmpParameters];
        
        if ([method isEqualToString:@"GET"] || [method isEqualToString:@"HEAD"] || [method isEqualToString:@"DELETE"]) {
            NSString *paramString = [[parameters JSONString] zf_base64EncodedString];
            NSURL *url = request.URL;
            url = [NSURL URLWithString:[[url absoluteString] stringByAppendingFormat:[path rangeOfString:@"?"].location == NSNotFound ? @"?%@" : @"&%@", paramString]];
//            url = [NSURL URLWithString:[[url absoluteString] stringByAppendingFormat:@"/%@", paramString]];
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

//上传二进制文件
- (void)postFormData:(NSData*)data name:(NSString*)name fileName:(NSString*)fileName parameters:(NSDictionary*)param Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
//    NSMutableURLRequest *myRequest = [self multipartFormRequestWithMethod:@"POST" path:REMARK_AUDIO_FILE parameters:param constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
//        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"audio/x-wav"];
//    }];
//    
//    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc] initWithRequest:myRequest];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        success(operation, responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(operation, error);
//    }];
//    
//    [operation start];
}

@end
