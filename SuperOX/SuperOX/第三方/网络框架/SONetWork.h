//
//  SONetWork.h
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SONetWork : NSObject

+ (instancetype)shareNetWork;

+ (void)postWithURL:(NSString *)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject, NSString *responseString))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
+ (void)postWithURL:(NSString *)url parameters:(id)parameters progress:(void (^)(NSProgress *downloadProgress))downloadProgress success:(void (^)(NSURLSessionDataTask *task, id responseObject, NSString *responseString))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


+ (void)getWithURL:(NSString *)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject, NSString *responseString))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
+ (void)getWithURL:(NSString *)url parameters:(id)parameters progress:(void (^)(NSProgress *downloadProgress))downloadProgress success:(void (^)(NSURLSessionDataTask *task, id responseObject, NSString *responseString))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (void)putWithURL:(NSString *)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject, NSString *responseString))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


+ (void)deleteWithURL:(NSString *)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject, NSString *responseString))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (void)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block progress:(void (^)(NSProgress *uploadProgress)) uploadProgress success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
