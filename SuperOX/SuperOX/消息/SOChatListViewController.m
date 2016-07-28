//
//  SOChatListViewController.m
//  SuperOX
//
//  Created by changxicao on 16/7/28.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOChatListViewController.h"
#import "UITableView+MJRefresh.h"

@interface SOChatListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SOChatListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initView
{
    [self.tableView addHeaderRefesh:YES andFooter:NO footerTitle:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
