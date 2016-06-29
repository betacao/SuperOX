//
//  defineString.h
//  SuperOX
//
//  Created by changxicao on 16/5/24.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#ifndef defineString_h
#define defineString_h

//版本
#define kSuperOXVersion @"superOXVersion"

//个人信息
#define KEY_USERIDENTFIER       @"com.SuperOX.userIdentfier"
#define KEY_AUTOLOGIN           @"com.SuperOX.autoLogin"
#define KEY_TOKEN               @"com.SuperOX.token"
#define KEY_PHONE               @"com.SuperOX.keyPhone"

#define signCode                @"dLaQd27R9VzpHV78l8KVbmj6m9QWAJ6Ou+yT6TScNbkOEBGczycc32ivA79Qzgx1m3Tf0xGzufnkBlvkw2plKrlslKVtP2fR3mTePR8PM6u01Y36/1P7egMCmbe94c0N6oC88fay37yCbuA7Ulkclp5b//yS30jB1MDiZPll9per8V65epLyMEKPbZTsh7hG7psMiZdE67EBG4hE0DU3d3Yc7yZJQFJGIhT5KCzJC9+cCrbDEwe6EojP2hRcOV8D2CyoDSaVRAI="

#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kSplashScreenAdCacheImgLocalPath ([kPathDocument stringByAppendingPathComponent:@"SplashScreenAdCacheImg.ad"])

#define kSplashScreenAdCacheLocalPath ([kPathDocument stringByAppendingPathComponent:@"SplashScreenAdCache.ad"])

#endif /* defineString_h */
