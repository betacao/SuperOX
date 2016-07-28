//
//  SOSearchBar.m
//  SuperOX
//
//  Created by changxicao on 16/7/28.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOSearchBar.h"

@implementation SOSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0.0f, 0.0f, SCREENWIDTH, 44.0f);
    self.needLineView = YES;
    self = [super initWithFrame:frame];
    if (self) {
        self.translucent = NO;
        self.barTintColor = [UIColor colorWithHexString:@"E8E8E8"];
        self.searchBarStyle = UISearchBarStyleDefault;
        UIView *view = [self.subviews firstObject];
        for (id object in view.subviews) {
            if ([object isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                UITextField *textField = (UITextField *)object;
                textField.textColor = Color(@"3c3c3c");
                [textField setValue:Color(@"bebebe") forKeyPath:@"_placeholderLabel.textColor"];
                [textField setValue:FontFactor(15.0f) forKeyPath:@"_placeholderLabel.font"];
                textField.enablesReturnKeyAutomatically = YES;
            } else if ([object isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){

            } else{

            }
        }
        [self setImage:[UIImage imageNamed:@"emsearch_icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"efeeef"]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(frame) - 1.0f, SCREENWIDTH, 0.5f)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"E6E7E8"];
        [self addSubview:lineView];
    }
    return self;
}

- (void)setBackgroundImageColor:(UIColor *)backgroundImageColor
{
    _backgroundImageColor = backgroundImageColor;
    [self setBackgroundImage:[UIImage imageWithColor:backgroundImageColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    UIView *view = [self.subviews firstObject];
    for (id object in view.subviews) {
        if ([object isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
        } else if ([object isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {

            UITextField *textField = (UITextField *)object;
            [textField setValue:Color(@"bebebe") forKeyPath:@"_placeholderLabel.textColor"];

        } else if ([object isKindOfClass:NSClassFromString(@"UINavigationButton")]){
            UIButton *button = (UIButton *)object;
            button.enabled = YES;
            if (!self.cancelButtonTitleColor) {
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            } else{
                [button setTitleColor:self.cancelButtonTitleColor forState:UIControlStateNormal];
            }
        } else{
            if (!self.needLineView) {
                UIView *view = (UIView *)object;
                [view removeFromSuperview];
            }
        }
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    UIView *view = [self.subviews firstObject];
    for (id object in view.subviews) {
        if ([object isKindOfClass:NSClassFromString(@"UINavigationButton")]){
            UIButton *button = (UIButton *)object;
            [button setTitle:@"取消" forState:UIControlStateNormal];
            button.titleLabel.font = FontFactor(15.0f);
        }
    }
}

@end
