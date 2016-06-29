//
//  SOBaseTableViewController.m
//  SuperOX
//
//  Created by changxicao on 16/6/28.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOBaseTableViewController.h"

@interface SOBaseTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SOBaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


@end
