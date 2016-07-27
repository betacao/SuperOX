//
//  SONetWork.m
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SONetWork.h"
#import "SHGEncryptionAlgorithm.h"

@interface SONetWork()

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation SONetWork

+ (instancetype)shareNetWork
{
    static SONetWork *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _manager;
}

#pragma mark------post
+ (void)postWithURL:(NSString *)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id, NSString *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [SONetWork postWithURL:url parameters:parameters progress:nil success:success failure:failure];
}

+ (void)postWithURL:(NSString *)url parameters:(id)parameters progress:(void (^)(NSProgress *))downloadProgress success:(void (^)(NSURLSessionDataTask *, id, NSString *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    AFHTTPSessionManager *session = [SONetWork shareNetWork].manager;
    parameters = [SONetWork packParameters:parameters];
    [session POST:url parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSString *string = [responseObject objectForKey:@"data"];
        if (error && failure) {
            failure(task, error);
        } else if(success) {
            success(task, responseObject, string);
        }
    } failure:failure];
}

#pragma mark------get
+ (void)getWithURL:(NSString *)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id, NSString *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    [SONetWork getWithURL:url parameters:parameters progress:nil success:success failure:failure];
}

+ (void)getWithURL:(NSString *)url parameters:(id)parameters progress:(void (^)(NSProgress *))downloadProgress success:(void (^)(NSURLSessionDataTask *, id, NSString *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    AFHTTPSessionManager *session = [SONetWork shareNetWork].manager;
    parameters = [SONetWork packParameters:parameters];
    [session GET:url parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSString *string = [responseObject objectForKey:@"data"];
        if (error && failure) {
            failure(task, error);
        } else if(success) {
            success(task, responseObject, string);
        }
    } failure:failure];
}

#pragma mark------put
+ (void)putWithURL:(NSString *)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id, NSString *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    AFHTTPSessionManager *session = [SONetWork shareNetWork].manager;
    parameters = [SONetWork packParameters:parameters];
    [session PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSString *string = [responseObject objectForKey:@"data"];
        if (error && failure) {
            failure(task, error);
        } else if(success) {
            success(task, responseObject, string);
        }
    } failure:failure];
}


#pragma mark------delete

+ (void)deleteWithURL:(NSString *)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id, NSString *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    AFHTTPSessionManager *session = [SONetWork shareNetWork].manager;
    parameters = [SONetWork packParameters:parameters];
    [session DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSString *string = [responseObject objectForKey:@"data"];
        if (error && failure) {
            failure(task, error);
        } else if(success) {
            success(task, responseObject, string);
        }
    } failure:failure];
}

#pragma ------
+ (void)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    AFHTTPSessionManager *session = [SONetWork shareNetWork].manager;
    parameters = [SONetWork packParameters:parameters];
    [session POST:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:success failure:failure];
}


+ (NSDictionary *)packParameters:(id)parameters
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [param setObject:[SOGloble sharedGloble].currentVersion forKey:@"version"];
    [param setObject:@([[NSDate date] timeIntervalSince1970] * 1000) forKey:@"authTimestamp"];
    NSString *secret = [SONetWork sortParameter:param];

    NSString *code = signCode;
    for (NSInteger i = 0; i < 3; i++) {
        code = [SHGEncryptionAlgorithm textFromBase64String:code];
    }
    secret = [secret stringByAppendingString:code];
    for (NSInteger i = 0; i < 3; i++) {
        secret = [secret md5];
    }
    [param setObject:secret forKey:@"sign"];

    return param;
}

+ (NSString *)sortParameter:(id)param
{
    NSArray *keys = [param allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSMutableArray *sortedValues = [NSMutableArray array];
    for(id key in sortedArray) {
        id object = [param objectForKey:key];
        object = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)[NSString stringWithFormat:@"%@",object],NULL,CFSTR(":/=？：?#[]@!$ '()*+,;\"<>%&{}|\\^~`"),kCFStringEncodingUTF8));
        [sortedValues addObject:object];
    }

    __block NSString *result = @"";
    [sortedArray enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key, [sortedValues objectAtIndex:idx]]];
    }];
    if (!IsStringEmpty(result)) {
        result = [result substringToIndex:result.length - 1];

    }
    return result;
}

@end
