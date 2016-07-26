//
//  SODynamicViewController.m
//  SuperOX
//
//  Created by changxicao on 16/7/22.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SODynamicViewController.h"
#import "SOEmptyDataView.h"

@interface SODynamicViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) SOEmptyDataView *emptyDateView;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *listArray;
@property (strong, nonatomic) NSMutableArray *adArray;

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

- (void)initView
{
    self.tableView.hidden = YES;

    self.emptyDateView = [[SOEmptyDataView alloc] init];
    [self.view insertSubview:self.emptyDateView belowSubview:self.tableView];

    self.dataArray = [NSMutableArray array];
    self.listArray = [NSMutableArray array];
    self.adArray = [NSMutableArray array];
}

- (void)addAutoLayout
{
    self.tableView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0.0f, 0.0f, kTabBarHeight, 0.0f));
}

- (void)loadData
{
    [SODynamicManager loadDynamic:@{} inView:self.view block:^(NSArray *array) {

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
