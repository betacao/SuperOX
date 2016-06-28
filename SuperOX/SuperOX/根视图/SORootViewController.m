//
//  ViewController.m
//  SuperOX
//
//  Created by changxicao on 16/5/17.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SORootViewController.h"
#import "SOLoginViewController.h"
#import "SOLoginManager.h"
#import "SOGuideView.h"

@interface SORootViewController ()

@property (strong, nonatomic) SOGuideView *guideView;

@end

@implementation SORootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSThread sleepForTimeInterval:1.2f];
    if([[SOGloble sharedGloble] isShowGuideView]){
        [self startGuideView];
    } else{
        [self moveToHomePage];
    }
}

- (void)startGuideView
{
    WEAK(self, weakSelf);
    self.guideView = [[SOGuideView alloc] init];
    self.guideView.block = ^{
        [weakSelf moveToHomePage];
    };
    [self.view addSubview:self.guideView];
}

- (void)moveToHomePage
{
    NSString *flagStr = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_AUTOLOGIN];
    BOOL flag = NO;
    if (!IsStringEmpty(flagStr)){
        flag = [flagStr boolValue];
    }
    if (flag){
        [self autoLogin];
    } else{
        [self showLoginViewController];
    }
}

- (void)autoLogin
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_TOKEN];
    if(IsStringEmpty(KUID) || IsStringEmpty(token)){
        [self showLoginViewController];
        return;
    }
    [SOLoginManager autoLoginBlock:^{

    }];
}

- (void)showLoginViewController
{
//    SOLoginViewController *controller = [[SOLoginViewController alloc] init];
//    [AppDelegate currentAppdelegate].window.rootViewController = [[BaseNavigationController alloc] initWithRootViewController:vc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
