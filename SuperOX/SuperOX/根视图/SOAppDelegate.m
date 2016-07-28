//
//  AppDelegate.m
//  SuperOX
//
//  Created by changxicao on 16/5/17.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOAppDelegate.h"
#import "SOEaseMobManager.h"

@interface SOAppDelegate ()

@end

@implementation SOAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName:FontFactor(17.0f),NSForegroundColorAttributeName:[UIColor whiteColor]};

    EMOptions *options = [EMOptions optionsWithAppkey:KEY_HUANXIN];
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    [[EMClient sharedClient] addDelegate:[SOEaseMobManager shareManager] delegateQueue:dispatch_get_main_queue()];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
