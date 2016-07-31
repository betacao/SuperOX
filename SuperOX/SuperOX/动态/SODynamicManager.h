//
//  SODynamicManager.h
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODynamicObject.h"

@interface SODynamicManager : NSObject

+ (void)loadDynamic:(NSDictionary *)param inView:(UIView *)view block:(void(^)(NSArray *normalArray, NSArray *adArray))block;

+ (void)loadRegisterPushFriend:(NSDictionary *)param block:(void(^)(SONewFriendObject *object))block;

+ (void)loadRecommendFriends:(NSDictionary *)param block:(void(^)(NSArray *array))block;

@end
