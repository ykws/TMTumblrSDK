//
//  TMAPIClient+Blog.m
//  TumblrSDK
//
//  Created by Bryan Irace on 8/28/12.
//  Copyright (c) 2012 Bryan Irace. All rights reserved.
//

#import "TMAPIClient+Blog.h"

@implementation TMAPIClient (Blog)

- (JXHTTPOperation *)blogInfo:(NSString *)blogName success:(TMAPICallback)success error:(TMAPIErrorCallback)error {
    return [self get:[NSString stringWithFormat:@"blog/%@.tumblr.com/info", blogName] parameters:nil success:success
               error:error];
}

- (JXHTTPOperation *)followers:(NSString *)blogName parameters:(NSDictionary *)parameters success:(TMAPICallback)success
                         error:(TMAPIErrorCallback)error {
    return [self get:[NSString stringWithFormat:@"blog/%@.tumblr.com/followers", blogName] parameters:parameters success:success
               error:error];
}

- (JXHTTPOperation *)avatar:(NSString *)blogName size:(int)size success:(TMAPIDataCallback)success error:(TMAPIErrorCallback)error {
    NSString *URLString = [TMAPIBaseURL stringByAppendingString:[NSString stringWithFormat:@"blog/%@.tumblr.com/avatar/%d",
                                                                 blogName, size]];
    
    __block JXHTTPOperation *request = [JXHTTPOperation withURLString:URLString];
    
    request.completionBlock = ^ {
        if (request.responseStatusCode == 200) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(request.responseData);
                });
            }
        } else {
            error([NSError errorWithDomain:@"Request failed" code:request.responseStatusCode userInfo:nil]);
        }
    };
    
    [self sendRequest:request];
    
    return request;
}

- (JXHTTPOperation *)posts:(NSString *)blogName type:(NSString *)type parameters:(NSDictionary *)parameters
                   success:(TMAPICallback)success error:(TMAPIErrorCallback)error {
    NSString *path = [NSString stringWithFormat:@"blog/%@.tumblr.com/posts", blogName];
    if (type) path = [path stringByAppendingFormat:@"/%@", type];
    
    return [self get:path parameters:parameters success:success error:error];
}

- (JXHTTPOperation *)queue:(NSString *)blogName parameters:(NSDictionary *)parameters success:(TMAPICallback)success
                     error:(TMAPIErrorCallback)error {
    return [self get:[NSString stringWithFormat:@"blog/%@.tumblr.com/posts/queue", blogName] parameters:parameters
             success:success error:error];
}

- (JXHTTPOperation *)drafts:(NSString *)blogName parameters:(NSDictionary *)parameters success:(TMAPICallback)success
                      error:(TMAPIErrorCallback)error {
    return [self get:[NSString stringWithFormat:@"blog/%@.tumblr.com/posts/draft", blogName] parameters:parameters
             success:success error:error];
}

- (JXHTTPOperation *)submissions:(NSString *)blogName parameters:(NSDictionary *)parameters success:(TMAPICallback)success
                           error:(TMAPIErrorCallback)error {
    return [self get:[NSString stringWithFormat:@"blog/%@.tumblr.com/posts/submission", blogName] parameters:parameters
             success:success error:error];
}

@end