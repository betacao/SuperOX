//
//  SHGGuideView.h
//  Finance
//
//  Created by changxicao on 16/5/19.
//  Copyright © 2016年 HuMin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SOGuideViewBlock)();

@interface SOGuideView : UIView

@property (copy, nonatomic) SOGuideViewBlock block;

@end