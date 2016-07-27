//
//  SONoticeView.h
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOBaseView.h"
typedef NS_ENUM(NSInteger, SONoticeType)
{
    SONoticeTypeNewFriend = 0,
    SONoticeTypeNewMessage = 1
};

@interface SONoticeView : SOBaseView

@property (weak, nonatomic) UIView *superView;

- (void)loadUserUid:(NSString *)uid;
- (void)showWithText:(NSString *)string;
- (instancetype)initWithFrame:(CGRect)frame type:(SONoticeType)type;

@end