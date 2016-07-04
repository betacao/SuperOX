//
//  SOLoginObject.m
//  SuperOX
//
//  Created by changxicao on 16/6/8.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOLoginObject.h"

@implementation SOLoginObject

+ (instancetype)sharedLoginObject
{
    static SOLoginObject *sharedObject = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

- (void)setUserIdentfier:(NSString *)userIdentfier
{
    _userIdentfier = userIdentfier;
    [[NSUserDefaults standardUserDefaults] setObject:userIdentfier forKey:KEY_USERIDENTFIER];
}

@end
