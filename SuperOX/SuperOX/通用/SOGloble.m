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

- (void)checkForUpdate:(void (^)(BOOL state))block
{
    NSString *request = [NSString stringWithFormat:@"%@%@",kApiPath,@"/version"];
    [SONetWork getWithURL:request parameters:@{@"os":@"iOS"} success:^(NSURLSessionDataTask *task, id responseObject, NSDictionary *dictionary) {

    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
//    [MOCHTTPRequestOperationManager getWithURL:request parameters:@{@"os":@"iOS"} success:^(MOCHTTPResponse *response) {
//        NSDictionary *dictionary = response.dataDictionary;
//        NSString *version = [dictionary objectForKey:@"version"];
//        BOOL force = [[dictionary objectForKey:@"force"] isEqualToString:@"Y"] ? YES : NO;
//        NSString *detail = [dictionary objectForKey:@"detail"];
//
//        NSString *localVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
//        if ([localVersion compare:version options:NSNumericSearch] == NSOrderedAscending) {
//            if (block) {
//                block(YES);
//            } else{
//                UILabel *label = [[UILabel alloc] init];
//                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//                style.lineSpacing = MarginFactor(4.0f);
//                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:detail attributes:@{NSParagraphStyleAttributeName:style, NSForegroundColorAttributeName:Color(@"8d8d8d"), NSFontAttributeName:FontFactor(17.0f)}];
//                label.attributedText = string;
//                label.numberOfLines = 0;
//                label.origin = CGPointMake(MarginFactor(26.0f), MarginFactor(17.0f));
//                CGSize size = [label sizeThatFits:CGSizeMake(MarginFactor(300.0f) - 2 * MarginFactor(26.0f), CGFLOAT_MAX)];
//                label.size = size;
//                UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, MarginFactor(300.0f), size.height + MarginFactor(17.0f))];
//                [contentView addSubview:label];
//                SOAlertView *alert = [[SOAlertView alloc] initWithTitle:@"版本更新" customView:contentView leftButtonTitle:nil rightButtonTitle:@"立即更新"];
//                [alert addSubTitle:[@"V" stringByAppendingString: version]];
//                alert.rightBlock = ^{
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/da-niu-quan-jin-rong-zheng/id984379568?mt=8"]];
//                };
//                alert.shouldDismiss = NO;
//                if(force){
//                    [alert show];
//                } else{
//                    [alert showWithClose];
//                }
//            }
//        } else{
//            if (block) {
//                block(NO);
//            }
//        }
//
//    } failed:^(MOCHTTPResponse *response) {
//        if (block) {
//            block(NO);
//        }
//    }];
}
@end
