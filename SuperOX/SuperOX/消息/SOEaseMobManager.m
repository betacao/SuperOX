//
//  SOEaseMobManager.m
//  SuperOX
//
//  Created by changxicao on 16/7/27.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOEaseMobManager.h"

@implementation SOEaseMobManager

+ (instancetype)shareManager
{
    static SOEaseMobManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)didAutoLoginWithError:(EMError *)aError
{

}

- (void)didLoginFromOtherDevice
{

}

- (void)didRemovedFromServer
{

}

- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState
{

}

@end
