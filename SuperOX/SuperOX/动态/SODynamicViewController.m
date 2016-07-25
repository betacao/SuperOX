//
//  SODynamicViewController.m
//  SuperOX
//
//  Created by changxicao on 16/7/22.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SODynamicViewController.h"

@interface SODynamicViewController ()

@end

@implementation SODynamicViewController

+ (instancetype)sharedController
{
    static SODynamicViewController *controller = nil;
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
