//
//  SOProgressHUD.h
//  Finance
//
//  Created by changxicao on 16/3/21.
//  Copyright © 2016年 HuMin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SOProgressHUDType)
{
    SOProgressHUDTypeNormal = 0,
    SOProgressHUDTypeGray
};

@interface SOProgressHUD : UIView

@property (assign, nonatomic) BOOL shouldAutoMediate;

@property (assign, nonatomic) SOProgressHUDType type;

- (void)startAnimation;

- (void)stopAnimation;

- (CGSize)SOProgressHUDSize;

@end
