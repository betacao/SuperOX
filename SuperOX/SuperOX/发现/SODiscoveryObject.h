//
//  SODiscoveryObject.h
//  SuperOX
//
//  Created by changxicao on 16/7/29.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SODiscoveryObject : NSObject

@property (strong, nonatomic) NSString *industryNum;
@property (strong, nonatomic) NSString *industryName;
@property (strong, nonatomic) NSString *industry;
@property (strong, nonatomic) UIImage *industryImage;

@end

typedef NS_ENUM(NSInteger, SODiscoveryGroupingType) {
    SODiscoveryGroupingTypeIndustry,
    SODiscoveryGroupingTypePosition
};

@interface SODiscoveryIndustryObject : NSObject

@property (strong, nonatomic) NSString *module;
@property (strong, nonatomic) NSString *counts;
@property (strong, nonatomic) NSString *moduleName;
//不是由服务器返回的 自己创建
@property (assign, nonatomic) SODiscoveryGroupingType moduleType;

@end

@interface SODiscoveryPeopleObject : NSObject

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *area;
@property (assign, nonatomic) BOOL status;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *headImg;
@property (assign, nonatomic) BOOL isAttention;
@property (assign, nonatomic) BOOL hideAttation;
@property (strong, nonatomic) NSString *realName;
@property (strong, nonatomic) NSString *industry;
@property (assign, nonatomic) BOOL businessStatus;

@end

@interface SODiscoveryInvateObject : NSObject

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *realName;

@end

@interface SODiscoveryDepartmentObject : NSObject

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) UIImage *friendTypeImage;
@property (strong, nonatomic) NSString *commonFriendCount;
@property (strong, nonatomic) NSString *realName;
@property (strong, nonatomic) NSString *commonFriend;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *headImg;
@property (strong, nonatomic) NSString *area;
@property (assign, nonatomic) BOOL isAttention;
@property (assign, nonatomic) BOOL hideAttation;
@property (assign, nonatomic) BOOL userStatus;
@property (assign, nonatomic) BOOL businessStatus;

@end

@interface SODiscoveryRecommendObject : NSObject

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *picName;
@property (strong, nonatomic) NSString *realName;
@property (strong, nonatomic) NSString *companyName;
@property (assign, nonatomic) BOOL isAttention;
@property (assign, nonatomic) BOOL userStatus;
@property (assign, nonatomic) BOOL hideAttation;

@end