//
//  SOGloble.h
//  SuperOX
//
//  Created by changxicao on 16/5/23.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOGloble : NSObject

#pragma mark ------属性------
/**
 @brief  当前的省份名称

 @since 1.4.1
 */
@property (strong, nonatomic) NSString *provinceName;

/**
 @brief  当前城市的名称

 @since 1.4.1
 */
@property (strong, nonatomic) NSString *cityName;

/**
 @brief 当前app的版本号

 @since 1.8.1_01
 */
@property (strong, nonatomic) NSString *currentVersion;

/**
 @brief 当前手机的型号

 @since 1.8.2
 */
@property (strong, nonatomic) NSString *platform;


#pragma mark ------函数------

/**
 @brief  globle单例

 @return 当前对象

 @since 1.4.1
 */
+ (instancetype)sharedGloble;

/**
 @brief  是否需要启动界面

 @return 是否是第一次启动 或者是升级了应用

 @since 1.5.0
 */
- (BOOL)isShowGuideView;

/**
 @brief  检查更新并提示

 @param state 是否有新版本
 @param block 有新版本的操作

 @since 1.8
 */
+ (void)checkForUpdate:(void(^)(BOOL state))block;

/**
 @breief  记录用户行为

 @since 1.7
 */
+ (void)recordUserAction:(NSString *)recordIdStr type:(NSString *)typeStr;

@end
