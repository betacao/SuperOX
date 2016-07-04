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
            

            [[NSUserDefaults standardUserDefaults] setObject:token forKey:KEY_TOKEN];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KEY_AUTOLOGIN];
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
        NSDictionary *dictionary = response.dataDictionary;
        SOLoginObject *object = [SOLoginObject sharedLoginObject];
        object.userLocation = [dictionary objectForKey:@"area"];
        object.userHeaderImageUrl = [dictionary objectForKey:@"head_img"];
        object.userIsFull = [dictionary objectForKey:@"isfull"];
        object.userName = [dictionary objectForKey:@"name"];
        object.userRecommend = [dictionary objectForKey:@"recommend"];
        object.userAuthState = [dictionary objectForKey:@"state"];
        object.userIdentfier = [dictionary objectForKey:@"uid"];

        NSString *token = [dictionary objectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:KEY_TOKEN];

        block(YES);
    } failed:^(MOCHTTPResponse *response){
        [view hideHud];
        [view showWithText:response.errorMessage];
    }];
}
@end
