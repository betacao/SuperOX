//
//  SOSearchBar.h
//  SuperOX
//
//  Created by changxicao on 16/7/28.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOSearchBar : UISearchBar

@property (assign, nonatomic) BOOL needLineView;
@property (strong, nonatomic) UIColor *cancelButtonTitleColor;
@property (strong, nonatomic) UIColor *backgroundImageColor;

@end
