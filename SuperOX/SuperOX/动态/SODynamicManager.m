//
//  SODynamicManager.m
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SODynamicManager.h"

@implementation SODynamicManager

+ (void)loadDynamic:(NSDictionary *)dictionary inView:(UIView *)view block:(void (^)(NSArray *))block
{
    [view showLoading];
//    [MOCHTTPRequestOperationManager getWithURL:[NSString stringWithFormat:@"%@/%@",kApiPath,@"dynamic/dynamicNew"] parameters:dictionary success:^(MOCHTTPResponse *response){
//        [view hideHud];
//        [weakSelf assembleDictionary:response.dataDictionary target:target];
//
//    } failed:^(MOCHTTPResponse *response){
//        weakSelf.isRefreshing = NO;
//        [Hud showMessageWithText:response.errorMessage];
//        NSLog(@"%@",response.errorMessage);
//        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf.tableView.mj_footer endRefreshing];
//        [Hud hideHud];
//    }];
}

@end
