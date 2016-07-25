//
//  SOTabbarViewController.m
//  SuperOX
//
//  Created by changxicao on 16/7/4.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOTabbarViewController.h"
#import "SODynamicViewController.h"

@interface SOTabbarViewController ()

@property (strong, nonatomic) SODynamicViewController *dynamicViewController;

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
//        [[SOGloble sharedGloble] checkForUpdate:nil];
    });
    [self initView];
}

- (void)initView
{
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    [self.tabBar setShadowImage:[UIImage imageWithColor:Color(@"e2e2e2")]];

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"949494"],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"E21F0D"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

    self.dynamicViewController = [SODynamicViewController sharedController];
    
    [self initSubPage];

}

- (void)initSubPage
{
    //首页
    UIImage *image = [UIImage imageNamed:@"home_normal"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [UIImage imageNamed:@"home_selected"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.dynamicViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"动态" image:image selectedImage:selectedImage];

    self.viewControllers = @[self.dynamicViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
