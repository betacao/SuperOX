//
//  SONoticeView.m
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#define kNoticeFriendViewHeight MarginFactor(30.0f)
#define kCloseButtonMargin MarginFactor(25.0f)
#define kCloseButtonEnlargeEdge 20.0f
#define kNoticeMessageViewHeight MarginFactor(25.0f)
#define kNoticeLeftMargin 0.0f

#import "SONoticeView.h"

@interface SONoticeView()

@property (strong, nonatomic) UILabel *noticeLabel;
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIButton *closeButton;
@property (strong, nonatomic) NSString *uid;
@property (assign, nonatomic) SONoticeType noticeType;

@end

@implementation SONoticeView

- (instancetype)initWithFrame:(CGRect)frame type:(SONoticeType)type
{

    self = [super initWithFrame:CGRectZero];
    if(self){
        switch (type) {
            case SONoticeTypeNewFriend:{
                self.frame = CGRectMake(0.0f, 0.0f, SCREENWIDTH, kNoticeFriendViewHeight);
            }
                break;

            default:{
                self.frame = CGRectMake(kNoticeLeftMargin, 0.0f, SCREENWIDTH - 2 * kNoticeLeftMargin, kNoticeMessageViewHeight);
                self.noticeType = type;
            }
                break;
        }
        self.clipsToBounds = YES;
        self.bgView.backgroundColor = [UIColor colorWithHexString:@"E0EBFD"];
    }
    return self;
}

- (UILabel *)noticeLabel
{
    if(!_noticeLabel){
        _noticeLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _noticeLabel.textColor = [UIColor colorWithHexString:@"5785d0"];
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
        _noticeLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _noticeLabel;
}

- (UIButton *)closeButton
{
    if(!_closeButton){
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setEnlargeEdge:kCloseButtonEnlargeEdge];
        [_closeButton setImage:[UIImage imageNamed:@"noticeClose"] forState:UIControlStateNormal];
        [_closeButton sizeToFit];
        CGRect frame = _closeButton.frame;
        frame.origin.y = (CGRectGetHeight(self.frame) - CGRectGetHeight(frame)) / 2.0f;
        frame.origin.x = SCREENWIDTH - kCloseButtonMargin;
        _closeButton.frame = frame;
        [_closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        if(self.noticeType == SONoticeTypeNewMessage){
            _closeButton.hidden = YES;
        }
    }
    return _closeButton;
}


- (UIView *)bgView
{
    if(!_bgView){
        CGRect frame = self.bounds;
        frame.origin.y = -CGRectGetHeight(frame);
        _bgView = [[UIView alloc] initWithFrame:frame];
        [_bgView addSubview:self.noticeLabel];
        [_bgView addSubview:self.closeButton];
        [self addSubview:_bgView];
    }
    return _bgView;

}

- (void)showWithText:(NSString *)string
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if(self.noticeType == SONoticeTypeNewMessage){
        [self performSelector:@selector(hide) withObject:nil afterDelay:1.5f];
    }
    self.noticeLabel.text = string;
    [self.superView addSubview:self];
    [UIView animateWithDuration:0.25f animations:^{
        CGRect frame = self.bounds;
        frame.origin.y = 0.0f;
        self.bgView.frame = frame;
    } completion:^(BOOL finished) {

    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.25f animations:^{
        CGRect frame = self.bounds;
        frame.origin.y = -CGRectGetHeight(frame);
        self.bgView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];

    }];
}

- (void)loadUserUid:(NSString *)uid
{
    self.uid = uid;
}

@end
