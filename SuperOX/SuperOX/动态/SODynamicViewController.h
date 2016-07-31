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

@property (strong, nonatomic) NSMutableArray *recommendArray;
@property (strong, nonatomic) SONewFriendObject *friendObject;

+ (instancetype)sharedController;

- (UIBarButtonItem *)leftBarButtonItem;
- (UIBarButtonItem *)rightBarButtonItem;

@end
