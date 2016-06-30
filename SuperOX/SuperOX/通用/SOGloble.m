//
//  SOGloble.m
//  SuperOX
//
//  Created by changxicao on 16/5/23.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOGloble.h"
#import "sys/utsname.h"

@interface SOGloble()

/**
 @brief  当前用户名(备份用的，对比之前的用户名有没有变化)

 @since 1.5.0
 */
@property (strong, nonatomic) NSString *currentUserID;

@end

@implementation SOGloble

+ (instancetype)sharedGloble
{
    static SOGloble *sharedGlobleInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedGlobleInstance = [[self alloc] init];
    });
    return sharedGlobleInstance;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        self.cityName = @"";
        self.provinceName = @"";
    }
    return self;
}

- (BOOL)isShowGuideView
{
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kSuperOXVersion];
    if(!oldVersion || ![oldVersion isEqualToString:self.currentVersion]){
        [[NSUserDefaults standardUserDefaults] setObject:self.currentVersion forKey:kSuperOXVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    return NO;
}

- (NSString *)currentVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)platform
{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}


- (NSArray *)parseServerJsonArrayToJSONModel:(NSArray *)array class:(Class)class
{
    if ([class isSubclassOfClass:[MTLModel class]]) {
        NSMutableArray *saveArray = [NSMutableArray array];
        for(id obj in array){
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSError *error;
                id model = [MTLJSONAdapter modelOfClass:class fromJSONDictionary:obj error:&error];
                if (error) {
                    MOCLogDebug(error.domain);
                }else{
                    [saveArray addObject:model];
                }
            }else{
                MOCLogDebug(@"服务器返回的数据应该为字典形式");
            }
        }
        return saveArray;
    }else{
        MOCLogDebug(@"class没有继承于JSONModel,只做单纯的返回数据,不处理");
        return nil;
    }
}

@end
