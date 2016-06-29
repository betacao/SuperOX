//
//  SOLoginManager.m
//  SuperOX
//
//  Created by changxicao on 16/6/8.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOLoginManager.h"
#import "SOLoginObject.h"

@implementation SOLoginManager

+ (instancetype)shareManager
{
    static SOLoginManager *sharedGlobleInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedGlobleInstance = [[self alloc] init];
    });
    return sharedGlobleInstance;
}

+ (void)autoLoginBlock:(void (^)(void))block
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_TOKEN];
    NSDictionary *param = @{@"uid":KUID,@"t":token, @"appv":[SOGloble sharedGloble].currentVersion};
    [MOCHTTPRequestOperationManager postWithURL:[kApiPath stringByAppendingString:@"/login/auto"]parameters:param success:^(MOCHTTPResponse *response){
        NSString *code =[response.data valueForKey:@"code"];
        if ([code isEqualToString:@"000"]){
            NSDictionary *dictionary = response.dataDictionary;
            SOLoginObject *object = [[[SOGloble sharedGloble] parseServerJsonArrayToJSONModel:@[dictionary] class:[SOLoginObject class]] firstObject];

            [[NSUserDefaults standardUserDefaults] setObject:object.userIdentfier forKey:KEY_USERIDENTFIER];
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:KEY_TOKEN];
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:KEY_AUTOLOGIN];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }failed:^(MOCHTTPResponse *response){
        
    }];
}

+ (void)login:(NSString *)phone inView:(UIView *)view complete:(void (^)(BOOL))block
{
    [view showLoading];
    [MOCHTTPRequestOperationManager getWithURL:[NSString stringWithFormat:@"%@/%@/%@",kApiPath,@"login",@"validate"] parameters:@{@"phone":phone}success:^(MOCHTTPResponse *response){
        [view hideHud];
        [[NSUserDefaults standardUserDefaults] setObject:phone forKey:KEY_PHONE];
        NSString *state = response.dataDictionary[@"state"];
        block([state boolValue]);
    } failed:^(MOCHTTPResponse *response){
        [view hideHud];
        [view showWithText:response.errorMessage];
    }];
}
@end
