//
//  const.h
//  SuperOX
//
//  Created by changxicao on 16/5/23.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#ifndef const_h
#define const_h

#ifdef DEBUG_TEST

#define kHostName @"http://120.26.114.154:8080/api"
#define kImageHostName @"http://daniuquan-test.oss-cn-qingdao.aliyuncs.com/"

#else

#define kHostName @"http://www.daniuq.com/api"
#define kImageHostName @"http://daniuquan.oss-cn-qingdao.aliyuncs.com/"

#endif

#define kApiPath  [kHostName stringByAppendingString:@"/v2"]


#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

#define FontFactor(font)  [UIFont systemFontOfSize:(SCREENWIDTH >= 375.0f ? font : (font - 1.0f))]
#define BoldFontFactor(font)  [UIFont boldSystemFontOfSize:(SCREENWIDTH >= 375.0f ? font : (font - 1.0f))]
#define MarginFactor(x) floorf(SCREENWIDTH / 375.0f * x)

#define Color(color) [UIColor colorWithHexString: color]

#define WEAK(self, weakSelf) __weak typeof(self) weakSelf = self

#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define kStatusBarHeight CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)

#define kNavigationBarHeight CGRectGetHeight(self.navigationController.navigationBar.frame)

#define kTabBarHeight CGRectGetHeight([SOTabbarViewController sharedController].tabBar.frame)

#define SCALE [UIScreen mainScreen].scale

#define KUID [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERIDENTFIER]

///字符串是否为空
#define IsStringEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
///数组是否为空
#define IsArrayEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))
#define MOCLogDebug(_ref)  NSLog(@"%@ %@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd),_ref);

#endif /* const_h */
