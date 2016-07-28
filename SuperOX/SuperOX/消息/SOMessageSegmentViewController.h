//
//  SOMessageSegmentViewController.h
//  SuperOX
//
//  Created by changxicao on 16/7/28.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOBaseViewController.h"

@interface SOMessageSegmentViewController : SOBaseViewController

@property (nonatomic, copy  ) NSArray              *viewControllers;
@property (nonatomic, weak  ) UIViewController     *selectedViewController;
@property (nonatomic, assign) NSUInteger           selectedIndex;

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setSelectedViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
