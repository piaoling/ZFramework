//
//  AFBase64JSONRequestOperation.m
//  TuNiuApp
//
//  Created by Yu Liang on 13-8-15.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import "ZFBase64JSONRequestOperation.h"
#import "Base64.h"
#import "JSONKit.h"

NSString * const ZFBusinessErrorDomain = @"ZFBusinessErrorDomain";

static dispatch_queue_t base64_json_request_operation_processing_queue() {
    static dispatch_queue_t tn_base64_json_request_operation_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tn_base64_json_request_operation_processing_queue = dispatch_queue_create("com.alamofire.networking.base64-json-request.processing", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return tn_base64_json_request_operation_processing_queue;
}

@interface ZFBase64JSONRequestOperation ()

@property (readwrite, nonatomic, strong) id responseJSONBase64Object;
@property (readwrite, nonatomic, strong) NSError *base64Error;
@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;

@property (readwrite, nonatomic, strong) NSError *formatedError; //Http错误及decode错误
@property (readwrite, nonatomic, strong) NSError* businessError;

@end

@implementation ZFBase64JSONRequestOperation

- (id)responseJSONBase64Object {
    [self.lock lock];
    if (!_responseJSONBase64Object && [self.responseData length] > 0 && [self isFinished] && !self.base64Error) {
        NSError *error = nil;
        
        NSString *responseJSONString = [NSString zf_stringWithBase64EncodedString:self.responseString]; //base64 decode
        if (responseJSONString) {
            self.responseJSONBase64Object = [responseJSONString objectFromJSONString]; //json decode
        } else {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            [userInfo setValue:@"Operation responseData failed decoding as a UTF-8 string" forKey:NSLocalizedDescriptionKey];
            [userInfo setValue:[NSString stringWithFormat:@"Could not decode string: %@", self.responseString] forKey:NSLocalizedFailureReasonErrorKey];
            error = [[NSError alloc] initWithDomain:AFNetworkingErrorDomain code:NSURLErrorCannotDecodeContentData userInfo:userInfo];
        }
        
        self.base64Error = error;
        
    }
    [self.lock unlock];
    
    return _responseJSONBase64Object;
}

- (NSError *)error {
    if (_base64Error) {
        return _base64Error;
    } else {
        return [super error];
    }
}

#pragma mark - AFHTTPRequestOperation

+ (NSSet *)acceptableContentTypes {
    return [NSSet setWithObjects:@"text/html", @"text/javascript", nil];
}

+ (BOOL)canProcessRequest:(NSURLRequest *)request {
    return [super canProcessRequest:request];
}

- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
#pragma clang diagnostic ignored "-Wgnu"
    
    self.completionBlock = ^ {
        if (self.error) {
            DLog(@"\n Http error:%@ \n Http request:%@ \n Http menthod:%@ \n Http encode body:%@ \n Http decode body:%@",
                 self.error,
                 self.request,
                 self.request.HTTPMethod,
                 [[NSString alloc] initWithData:self.request.HTTPBody encoding:NSUTF8StringEncoding],
                 [[[NSString alloc] initWithData:self.request.HTTPBody encoding:NSUTF8StringEncoding] zf_base64DecodedString]);
            
            [self formatError];
            if (failure) {
                
                dispatch_async(self.failureCallbackQueue ?: dispatch_get_main_queue(), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [UIAlertView showAlertViewWithTitle:@"网络异常" message:@"您的网络不可用" cancelButtonTitle:@"好" otherButtonTitle:nil];
                    });
                    failure(self, self.formatedError);
                });
            }
        } else {
            dispatch_async(base64_json_request_operation_processing_queue(), ^{
                NSDictionary *originObject = (NSDictionary *)self.responseJSONBase64Object;
                
                if (self.error) {
                    DLog(@"\n Http error:%@ \n Http request:%@ \n Http menthod:%@ \n Http encode body:%@ \n Http decode body:%@ \n Http response:%@",
                         self.error,
                         self.request,
                         self.request.HTTPMethod,
                         [[NSString alloc] initWithData:self.request.HTTPBody encoding:NSUTF8StringEncoding],
                         [[[NSString alloc] initWithData:self.request.HTTPBody encoding:NSUTF8StringEncoding] zf_base64DecodedString],
                         originObject);

                    [self formatError];
                    if (failure) {
                        dispatch_async(self.failureCallbackQueue ?: dispatch_get_main_queue(), ^{
                            failure(self, self.formatedError);
                        });
                    }
                } else {
                    DLog(@"\n Http request:%@ \n Http menthod:%@ \n Http encode body:%@ \n Http decode body:%@ \n Http response:%@",
                         self.request,
                         self.request.HTTPMethod,
                         [[NSString alloc] initWithData:self.request.HTTPBody encoding:NSUTF8StringEncoding],
                         [[[NSString alloc] initWithData:self.request.HTTPBody encoding:NSUTF8StringEncoding] zf_base64DecodedString],
                         originObject);
                    BOOL isSuccess = [originObject[@"success"] boolValue]; //操作是否成功
                    //操作成功
                    if (isSuccess) {
                        self.errorMessage = originObject[@"msg"];
                        
                        if (success) {
                            dispatch_async(self.successCallbackQueue ?: dispatch_get_main_queue(), ^{
                                if ([NSNull null] == originObject[@"data"]) {
                                    success(self, nil);
                                }
                                else{
                                    success(self, originObject[@"data"]);
                                }
                            });
                        }
                    //操作失败
                    } else {
                        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                        
                        [userInfo setValue:originObject[@"msg"] forKey:NSLocalizedDescriptionKey];
                        
                        id data = [originObject objectForKey:@"data"];
                        if (!data) {
                            data = [NSNull null];
                        }
                        [userInfo setObject:data forKey:@"data"];
                        
                        self.businessError = [[NSError alloc] initWithDomain:ZFBusinessErrorDomain code:[originObject[@"errorCode"] integerValue] userInfo:userInfo];
                        
                        if (failure) {
                            dispatch_async(self.failureCallbackQueue ?: dispatch_get_main_queue(), ^{
                                failure(self, self.businessError);
                            });
                        }
                    }
                }
            });
        }
    };
#pragma clang diagnostic pop
}


//屏蔽非业务逻辑错误
- (void)formatError
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:self.error.userInfo];
    userInfo[@"NSLocalizedDescriptionKey"] = @"服务出错";
    NSError *formatedError = [[NSError alloc] initWithDomain:self.error.domain code:self.error.code userInfo:userInfo];
    self.formatedError = formatedError;
}

@end
