//
//  SOLoginManager.h
//  SuperOX
//
//  Created by changxicao on 16/6/8.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOLoginManager : NSObject

+ (instancetype)shareManager;

+ (void)autoLoginBlock:(void(^)(void))block;

+ (void)login:(NSString *)phone inView:(UIView *)view complete:(void(^)(BOOL success))block;

@end
