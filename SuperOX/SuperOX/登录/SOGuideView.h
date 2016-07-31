//
//  SOGuideView.h
//  Finance
//
//  Created by changxicao on 16/5/19.
//  Copyright © 2016年 HuMin. All rights reserved.
//

#import "SOBaseView.h"

typedef void(^SOGuideViewBlock)();

@interface SOGuideView : SOBaseView

@property (copy, nonatomic) SOGuideViewBlock block;

@end