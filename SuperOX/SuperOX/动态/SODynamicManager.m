//
//  SODynamicManager.m
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SODynamicManager.h"

@implementation SODynamicManager

+ (void)loadDynamic:(NSDictionary *)param inView:(UIView *)view block:(void (^)(NSArray *, NSArray *))block
{
    [view showLoading];
    [SONetWork getWithURL:[NSString stringWithFormat:@"%@/%@",kApiPath,@"dynamic/dynamicNew"] parameters:param success:^(NSURLSessionDataTask *task, id responseObject, NSString *string) {
        [view hideHud];
        NSDictionary *dictionary = [string jsonValueDecoded];
        //普通数据
        NSArray *normalArray = [dictionary objectForKey:@"normalpostlist"];
        normalArray = [NSArray modelArrayWithClass:[SODynamicObject class] json:normalArray];
        //推广数据
        NSArray *adArray = [dictionary objectForKey:@"adlist"];
        adArray = [NSArray modelArrayWithClass:[SODynamicObject class] json:adArray];
        block(normalArray, adArray);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [view hideHud];
        block(nil, nil);
    }];
}

+ (void)loadRegisterPushFriend:(NSDictionary *)param block:(void(^)(SONewFriendObject *))block
{
    [SONetWork getWithURL:[kApiPath stringByAppendingString:@"/recommended/friends/registerPushFriendGrade"] parameters:@{@"uid":KUID} success:^(NSURLSessionDataTask *task, id responseObject, NSString *string) {
        
    } failure:nil];
}

+ (void)loadRecommendFriends:(NSDictionary *)param block:(void (^)(NSArray *))block
{
    [SONetWork getWithURL:[kApiPath stringByAppendingString:@"/recommended/friends/recommendedFriendGrade"] parameters:@{@"uid":KUID} success:^(NSURLSessionDataTask *task, id responseObject, NSString *string) {

    } failure:nil];
}

@end
