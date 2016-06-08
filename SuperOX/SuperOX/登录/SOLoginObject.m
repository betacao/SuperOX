//
//  SOLoginObject.m
//  SuperOX
//
//  Created by changxicao on 16/6/8.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOLoginObject.h"

@implementation SOLoginObject

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"userIdentfier":@"uid", @"userPhoneNumber":@"phone", @"userName":@"name", @"userLocation":@"area", @"userHeaderImageUrl":@"head_img", @"userAuthState":@"state", @"userIsFull":@"isfull"};
}

@end
