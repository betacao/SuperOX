//
//  SOGlobleOperation.m
//  Finance
//
//  Created by changxicao on 16/5/30.
//  Copyright © 2016年 HuMin. All rights reserved.
//

#import "SOGlobleOperation.h"
#import "SODiscoveryObject.h"
#import "SODynamicObject.h"
#import "SORecommendTableViewCell.h"

@interface SOGlobleOperation()

@property (strong, nonatomic) NSMutableArray *attationArray;

@end

@implementation SOGlobleOperation

+ (instancetype)sharedGloble
{
    static SOGlobleOperation *sharedGlobleInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedGlobleInstance = [[self alloc] init];
    });
    return sharedGlobleInstance;
}

- (NSMutableArray *)attationArray
{
    if (!_attationArray) {
        _attationArray = [NSMutableArray array];
    }
    return _attationArray;
}

+ (void)registerAttationClass:(Class)CClass method:(SEL)selector
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:NSStringFromClass(CClass) forKey:NSStringFromSelector(selector)];
    [[SOGlobleOperation sharedGloble].attationArray insertUniqueObject:dictionary];
}

+ (void)addAttation:(id)object inView:(UIView *)view
{
    [view showLoading];
    NSString *targetUserID = @"";
    BOOL attationState = NO;
    if ([object isKindOfClass:[SODynamicObject class]]) {
        SODynamicObject *circleListObject = (SODynamicObject *)object;
        targetUserID = circleListObject.userID;
        attationState = circleListObject.isAttention;
    } else if ([object isKindOfClass:[SODiscoveryPeopleObject class]]) {
        SODiscoveryPeopleObject *peopleObject = (SODiscoveryPeopleObject *)object;
        targetUserID = peopleObject.userID;
        attationState = peopleObject.isAttention;
        [SOGloble recordUserAction:targetUserID type:@"newdiscover_attention"];
    } else if ([object isKindOfClass:[SODiscoveryDepartmentObject class]]) {
        SODiscoveryDepartmentObject *departmentObject = (SODiscoveryDepartmentObject *)object;
        targetUserID = departmentObject.userID;
        attationState = departmentObject.isAttention;
        [SOGloble recordUserAction:targetUserID type:@"newdiscover_attention"];
    } else if ([object isKindOfClass:[SODiscoveryRecommendObject class]]) {
        SODiscoveryRecommendObject *recommendObject = (SODiscoveryRecommendObject *)object;
        targetUserID = recommendObject.userID;
        attationState = recommendObject.isAttention;
        [SOGloble recordUserAction:targetUserID type:@"newdiscover_attention"];
    } else if ([object isKindOfClass:[SORecommendObject class]]) {
        SORecommendObject *friendObject = (SORecommendObject *)object;
        targetUserID = friendObject.uid;
        attationState = friendObject.isAttention;
    }
    NSString *url = [kApiPath stringByAppendingString:@"friends"];
    NSDictionary *param = @{@"uid":KUID, @"oid":targetUserID};
    if (!attationState) {
        [SONetWork postWithURL:url parameters:param success:^(NSURLSessionDataTask *task, id responseObject, NSString *responseString) {
            [view hideHud];
            [view showWithText:@"关注成功"];
            [[SOGlobleOperation sharedGloble] addAttationSuccess:targetUserID attationState:YES];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [view hideHud];
            [view showWithText:error.localizedDescription];
        }];
    } else {
        [SONetWork deleteWithURL:url parameters:param success:^(NSURLSessionDataTask *task, id responseObject, NSString *responseString) {
            [view hideHud];
            [view showWithText:@"取消关注成功"];
            [[SOGlobleOperation sharedGloble] addAttationSuccess:targetUserID attationState:NO];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [view hideHud];
            [view showWithText:error.localizedDescription];
        }];
    }
}

- (void)addAttationSuccess:(NSString *)targetUserID attationState:(BOOL)attationState
{
    NSMutableArray *controllerArray = [NSMutableArray arrayWithArray:[SOTabbarViewController sharedController].navigationController.viewControllers];
    [controllerArray addObjectsFromArray:[SOTabbarViewController sharedController].viewControllers];
    [self.attationArray enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class = NSClassFromString([dictionary.allValues firstObject]);
        SEL selector = NSSelectorFromString([dictionary.allKeys firstObject]);
        for (UIViewController *controller in controllerArray) {
            if ([controller isKindOfClass:class]) {
                IMP imp = [controller methodForSelector:selector];
                void (*func)(id, SEL, id, BOOL) = (void *)imp;
                func(controller, selector, targetUserID, attationState);
            }
        }

    }];
}

@end

