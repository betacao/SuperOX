//
//  SOTabbarViewController.m
//  SuperOX
//
//  Created by changxicao on 16/7/4.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOTabbarViewController.h"
#import "SODynamicViewController.h"
#import "SOBusinessViewController.h"
#import "SODiscoveryViewController.h"
#import "SOUserCenterViewController.h"
#import "NSArray+Extend.h"

@interface SOTabbarViewController ()<UITabBarControllerDelegate>

@property (strong, nonatomic) NSArray *titleArray;
@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) SODynamicViewController *dynamicViewController;
@property (strong, nonatomic) SOBusinessViewController *businessViewController;
@property (strong, nonatomic) SODiscoveryViewController *discoveryViewController;
@property (strong, nonatomic) SOUserCenterViewController *userCenterViewController;

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
        [SOGloble checkForUpdate:nil];
    });

    [self initView];
}

- (void)initView
{
    self.delegate = self;
    self.tabBar.translucent = NO;
    self.titleArray = @[@"业务", @"动态", @"发现", @"我"];
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    [self.tabBar setShadowImage:[UIImage imageWithColor:Color(@"e2e2e2")]];

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"949494"],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"E21F0D"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

    self.dynamicViewController = [SODynamicViewController sharedController];
    self.businessViewController = [SOBusinessViewController sharedController];
    self.discoveryViewController = [SODiscoveryViewController sharedController];
    self.userCenterViewController = [SOUserCenterViewController sharedController];
    
    [self initSubPage];

}

- (void)initSubPage
{
    UIImage *image = [UIImage imageNamed:@"business_normal"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [UIImage imageNamed:@"business_selected"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.businessViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:[self.titleArray firstObject] image:image selectedImage:selectedImage];

    //首页
    image = [UIImage imageNamed:@"home_normal"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [UIImage imageNamed:@"home_selected"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.dynamicViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:[self.titleArray objectAtIndex:1] image:image selectedImage:selectedImage];


    image = [UIImage imageNamed:@"discovery_normal"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [UIImage imageNamed:@"discovery_selected"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.discoveryViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:[self.titleArray objectAtIndex:2] image:image selectedImage:selectedImage];

    //我的
    image = [UIImage imageNamed:@"my_normal"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [UIImage imageNamed:@"my_selected"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.userCenterViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:[self.titleArray lastObject] image:image selectedImage:selectedImage];

    self.viewControllers = @[self.businessViewController ,self.dynamicViewController, self.discoveryViewController, self.userCenterViewController];

    self.index = 0;
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    UIViewController *viewController = [self.viewControllers objectAtIndex:index];
    if ([viewController respondsToSelector:@selector(leftBarButtonItem)]) {
        self.navigationItem.leftBarButtonItem = [viewController performSelector:@selector(leftBarButtonItem)];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
    if ([viewController respondsToSelector:@selector(rightBarButtonItem)]) {
        self.navigationItem.rightBarButtonItem = [viewController performSelector:@selector(rightBarButtonItem)];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    self.title = [self.titleArray objectAtIndex:index];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

    self.index = [self.viewControllers indexOfObject:viewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
