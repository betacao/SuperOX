//
//  SODynamicManager.h
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SODynamicManager : NSObject

+ (void)loadDynamic:(NSDictionary *)dictionary inView:(UIView *)view block:(void(^)(NSArray *array))block;

@end
