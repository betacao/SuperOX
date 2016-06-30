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

+ (void)validate:(NSString *)phone inView:(UIView *)view complete:(void (^)(BOOL))block
{
    [view showLoading];

    [MOCHTTPRequestOperationManager getWithURL:[kApiPath stringByAppendingString:@"/login/validate"] parameters:@{@"phone":phone}success:^(MOCHTTPResponse *response){
        [view hideHud];
        [[NSUserDefaults standardUserDefaults] setObject:phone forKey:KEY_PHONE];
        NSString *state = [response.dataDictionary objectForKey:@"state"];
        block([state boolValue]);
    } failed:^(MOCHTTPResponse *response){
        [view hideHud];
        [view showWithText:response.errorMessage];
    }];
}

+ (void)login:(NSString *)password inView:(UIView *)view complete:(void (^)(BOOL))block
{
    [view showLoading];
    password = [password md5];
    NSDictionary *param = @{@"phone":[[NSUserDefaults standardUserDefaults] objectForKey:KEY_PHONE], @"pwd":password, @"ctype":@"iPhone", @"os":@"iOS", @"osv":[UIDevice currentDevice].systemVersion, @"appv":[SOGloble sharedGloble].currentVersion, @"yuncid":@"", @"yunuid":@"", @"phoneType":[SOGloble sharedGloble].platform};

    [MOCHTTPRequestOperationManager postWithURL:[kApiPath stringByAppendingString:@"/login"] class:nil parameters:param success:^(MOCHTTPResponse *response){
        [view hideHud];
//        NSString *uid = response.dataDictionary[@"uid"];
//        NSString *token = response.dataDictionary[@"token"];
//        NSString *state = response.dataDictionary[@"state"];
//        NSString *name = response.dataDictionary[@"name"];
//        NSString *head_img = response.dataDictionary[@"head_img"];
//        NSString *area = response.dataDictionary[@"area"];
//        weakSelf.isFull = response.dataDictionary[@"isfull"];
//        weakSelf.recommend = response.dataDictionary[@"recommend"];
//        [[NSUserDefaults standardUserDefaults] setObject:uid forKey:KEY_UID];
//        [[NSUserDefaults standardUserDefaults] setObject:password forKey:KEY_PASSWORD];
//        [[NSUserDefaults standardUserDefaults] setObject:state forKey:KEY_AUTHSTATE];
//        [[NSUserDefaults standardUserDefaults] setObject:name forKey:KEY_USER_NAME];
//        [[NSUserDefaults standardUserDefaults] setObject:head_img forKey:KEY_HEAD_IMAGE];
//        [[NSUserDefaults standardUserDefaults] setObject:token forKey:KEY_TOKEN];
//        [[NSUserDefaults standardUserDefaults] setObject:area forKey:KEY_USER_AREA];
//        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey: KEY_AUTOLOGIN];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        //环信登录
//        [weakSelf registerToken];
    } failed:^(MOCHTTPResponse *response){
        [view hideHud];
        [view showWithText:response.errorMessage];
    }];
}
@end
