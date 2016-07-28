//
//  SODynamicViewController.h
//  SuperOX
//
//  Created by changxicao on 16/7/22.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOBaseViewController.h"
#import "SODynamicObject.h"
#import "SODynamicManager.h"

@interface SODynamicViewController : SOBaseViewController

+ (instancetype)sharedController;

- (UIBarButtonItem *)leftBarButtonItem;
- (UIBarButtonItem *)rightBarButtonItem;

@end
