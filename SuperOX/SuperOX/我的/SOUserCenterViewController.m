//
//  SOUserCenterViewController.m
//  SuperOX
//
//  Created by changxicao on 16/7/25.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOUserCenterViewController.h"

@interface SOUserCenterViewController ()

@end

@implementation SOUserCenterViewController

+ (instancetype)sharedController
{
    static SOUserCenterViewController *controller = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        controller = [[self alloc] init];
    });
    return controller;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
