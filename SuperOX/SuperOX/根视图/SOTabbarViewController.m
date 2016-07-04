//
//  SOTabbarViewController.m
//  SuperOX
//
//  Created by changxicao on 16/7/4.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOTabbarViewController.h"

@interface SOTabbarViewController ()

@end

@implementation SOTabbarViewController

+ (instancetype)sharedController
{
    static SOTabbarViewController *controller = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        controller = [[self alloc] init];
    });
    return controller;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[SOGloble sharedGloble] checkForUpdate:nil];
    });
}

- (void)initView
{
    self.tabBar.tintColor = Color(@"ff3943");
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    [self.tabBar setShadowImage:[UIImage imageWithColor:Color(@"e2e2e2")]];

    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:Color(@"333333"), NSForegroundColorAttributeName, nil];;
    [[UITabBarItem appearance] setTitleTextAttributes:dictionary forState:UIControlStateNormal];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
