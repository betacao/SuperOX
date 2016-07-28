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
#import "SOAdvertisementView.h"
#import "SOBaseNavigationViewController.h"

@interface SORootViewController ()

@property (weak, nonatomic) IBOutlet SOAdvertisementView *advertisementView;
@property (strong, nonatomic) SOGuideView *guideView;

@end

@implementation SORootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    self.advertisementView.dissmissBlock = ^{
        if([[SOGloble sharedGloble] isShowGuideView]){
            [weakSelf startGuideView];
        } else{
            [weakSelf moveToHomePage];
        }
    };
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
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (isAutoLogin){
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
    [SOLoginManager autoLoginBlock:^(BOOL success) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                SOTabbarViewController *controller = [SOTabbarViewController sharedController];
                SOBaseNavigationViewController *navigationViewController = [[SOBaseNavigationViewController alloc] initWithRootViewController:controller];
                [self presentViewController:navigationViewController animated:YES completion:nil];
            });
        } else{
            [self showLoginViewController];
        }
    }];
}

- (void)showLoginViewController
{
    SOLoginViewController *controller = [[SOLoginViewController alloc] init];
    SOBaseNavigationViewController *navigationViewController = [[SOBaseNavigationViewController alloc] initWithRootViewController:controller];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:navigationViewController animated:YES completion:nil];
    });
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
