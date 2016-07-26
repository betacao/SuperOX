//
//  SOBaseNavigationViewController.m
//  SuperOX
//
//  Created by changxicao on 16/6/28.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOBaseNavigationViewController.h"

@interface SOBaseNavigationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property(weak, nonatomic) UIViewController *currentController;

@end

@implementation SOBaseNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    return self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    if ([viewController isKindOfClass:[SHGBusinessNewDetailViewController class]]) {
//
//        [self.navigationBar setShadowImage:[[UIImage alloc] init]];
//        [self.navigationBar setBackgroundImage:[CommonMethod imageWithColor:Color(@"f04f46")] forBarMetrics:UIBarMetricsDefault];
//    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(navigationController.viewControllers.count == 1) {
        self.currentController = nil;
    } else {
        self.currentController = viewController;
    }
    //    if (![viewController isKindOfClass:[SHGBusinessNewDetailViewController class]]) {
    [self.navigationBar setShadowImage:nil];
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:Color(@"d43c33")] forBarMetrics:UIBarMetricsDefault];
    //    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentController == self.topViewController);
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
        [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return YES;
    } else {
        return NO;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
