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
    static SOLoginManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

+ (void)autoLoginBlock:(void (^)(BOOL))block
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_TOKEN];
    NSDictionary *param = @{@"uid":KUID,@"t":token, @"appv":[SOGloble sharedGloble].currentVersion};
    [SONetWork postWithURL:[kApiPath stringByAppendingString:@"/login/auto"] parameters:param success:^(NSURLSessionDataTask *task, id responseObject, NSString *string) {
        NSString *code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"000"]){
            NSDictionary *dictionary = [string jsonValueDecoded];
            SOLoginObject *object = [SOLoginObject currentObject];
            object.userLocation = [dictionary objectForKey:@"area"];
            object.userHeaderImageUrl = [dictionary objectForKey:@"head_img"];
            object.userIsFull = [dictionary objectForKey:@"isfull"];
            object.userName = [dictionary objectForKey:@"name"];
            object.userRecommend = [dictionary objectForKey:@"recommend"];
            object.userAuthState = [dictionary objectForKey:@"state"];
            object.userIdentfier = [dictionary objectForKey:@"uid"];
            object.userCompanyName = [dictionary objectForKey:@"companyname"];

            NSString *token = [dictionary objectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:KEY_TOKEN];

            block(YES);
            [SOLoginManager loginToEaseMob:KUID password:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_PASSWORD]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(NO);
    }];
}

+ (void)validate:(NSString *)phone inView:(UIView *)view complete:(void (^)(BOOL))block
{
    [view showLoading];
    [SONetWork postWithURL:[kApiPath stringByAppendingString:@"/login/validate"] parameters:@{@"phone":phone} success:^(NSURLSessionDataTask *task, id responseObject, NSString *string) {
        [view hideHud];
        NSDictionary *dictionary = [string jsonValueDecoded];
        NSString *state = [dictionary objectForKey:@"state"];
        block([state boolValue]);
        [[NSUserDefaults standardUserDefaults] setObject:phone forKey:KEY_PHONE];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [view hideHud];
        [view showWithText:error.localizedDescription];
    }];
}

+ (void)login:(NSString *)password inView:(UIView *)view complete:(void (^)(BOOL))block
{
    [view showLoading];
    password = [password md5];
    NSDictionary *param = @{@"phone":[[NSUserDefaults standardUserDefaults] objectForKey:KEY_PHONE], @"pwd":password, @"ctype":@"iPhone", @"os":@"iOS", @"osv":[UIDevice currentDevice].systemVersion, @"appv":[SOGloble sharedGloble].currentVersion, @"yuncid":@"", @"yunuid":@"", @"phoneType":[SOGloble sharedGloble].platform};

    [SONetWork postWithURL:[kApiPath stringByAppendingString:@"/login"] parameters:param success:^(NSURLSessionDataTask *task, id responseObject, NSString *string) {
        [view hideHud];
        NSDictionary *dictionary = [string jsonValueDecoded];
        SOLoginObject *object = [SOLoginObject currentObject];
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

        [[NSUserDefaults standardUserDefaults] setObject:password forKey:KEY_PASSWORD];
        [SOLoginManager loginToEaseMob:KUID password:password];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [view hideHud];
        [view showWithText:error.localizedDescription];
    }];
}

+ (void)loginToEaseMob:(NSString *)userID password:(NSString *)password
{
    EMError *error = [[EMClient sharedClient] loginWithUsername:userID password:password];
    if (!error) {
        [[EMClient sharedClient].options setIsAutoLogin:YES];
    }
}

@end
