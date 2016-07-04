//
//  SOLoginObject.h
//  SuperOX
//
//  Created by changxicao on 16/6/8.
//  Copyright © 2016年 changxicao. All rights reserved.
//


@interface SOLoginObject : NSObject

+ (instancetype)sharedLoginObject;

@property (strong, nonatomic) NSString *userIdentfier;
@property (strong, nonatomic) NSString *userPhoneNumber;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userLocation;
@property (strong, nonatomic) NSString *userHeaderImageUrl;
@property (strong, nonatomic) NSString *userAuthState;
@property (strong, nonatomic) NSString *userIsFull;
//是否显示推荐界面
@property (strong, nonatomic) NSString *userRecommend;

@end
