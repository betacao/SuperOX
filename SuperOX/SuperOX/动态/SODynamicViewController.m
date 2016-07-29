//
//  SODynamicViewController.m
//  SuperOX
//
//  Created by changxicao on 16/7/22.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SODynamicViewController.h"
#import "SOEmptyDataView.h"
#import "SONoticeView.h"
#import "SONewFriendTableViewCell.h"
#import "SORecommendTableViewCell.h"
#import "SOExtendTableViewCell.h"
#import "SOMainPageTableViewCell.h"

#import "SOMessageSegmentViewController.h"
#import "UITableView+MJRefresh.h"

@interface SODynamicViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) SOEmptyDataView *emptyDateView;
@property (strong, nonatomic) SONoticeView *newMessageNoticeView;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *listArray;
@property (strong, nonatomic) NSMutableArray *adArray;

@property (strong, nonatomic) NSMutableArray *recommendArray;
@property (strong, nonatomic) SONewFriendObject *friendObject;
@property (assign, nonatomic) BOOL needRefreshTableView;

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
    //    [self loadDataWithTarget:@"first" dynamicID:@"-1"];
}

- (void)initView
{
    self.tableView.hidden = YES;
    self.tableView.backgroundColor = Color(@"efeeef");
    [self.tableView addHeaderRefesh:YES andFooter:YES footerTitle:nil];

    self.emptyDateView.hidden = NO;

    self.dataArray = [NSMutableArray array];
    self.listArray = [NSMutableArray array];
    self.adArray = [NSMutableArray array];
}

- (void)addAutoLayout
{
    self.tableView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0.0f, 0.0f, kTabBarHeight, 0.0f));
}

- (UIBarButtonItem *)leftBarButtonItem
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"newNews"];
    [leftButton setImage:image forState:UIControlStateNormal];
    [[leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        SOMessageSegmentViewController *controller = [[SOMessageSegmentViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    [leftButton sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (UIBarButtonItem *)rightBarButtonItem
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"sendCard"];
    [rightButton setImage:image forState:UIControlStateNormal];
    [[rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

    }];
    [rightButton sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (NSMutableArray *)recommendArray
{
    if(!_recommendArray){
        _recommendArray = [NSMutableArray array];
    }
    return _recommendArray;
}

- (SOEmptyDataView *)emptyDateView
{
    if (!_emptyDateView) {
        _emptyDateView = [[SOEmptyDataView alloc] init];
        [self.view insertSubview:_emptyDateView belowSubview:self.tableView];
    }
    return _emptyDateView;
}

- (SONoticeView *)newMessageNoticeView
{
    if(!_newMessageNoticeView){
        _newMessageNoticeView = [[SONoticeView alloc] initWithFrame:CGRectZero type:SONoticeTypeNewMessage];
        _newMessageNoticeView.superView = self.view;
    }
    return _newMessageNoticeView;
}

- (void)setNeedRefreshTableView:(BOOL)needRefreshTableView
{
    WEAK(self, weakSelf);
    if (needRefreshTableView && !_needRefreshTableView) {
        _needRefreshTableView = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            _needRefreshTableView = NO;
            if (weakSelf.dataArray.count > 0) {
                weakSelf.tableView.hidden = NO;
            } else {
                weakSelf.tableView.hidden = YES;
            }
            [weakSelf.tableView reloadData];
        });
    }
}

- (void)loadDataWithTarget:(NSString *)target dynamicID:(NSString *)dynamicID
{
    NSDictionary *param = @{@"uid":KUID, @"type":@"all", @"target":target, @"rid":dynamicID, @"num": @(10), @"tagId" : @"-1"};
    WEAK(self, weakSelf);
    [SODynamicManager loadDynamic:param inView:self.view block:^(NSArray *normalArray, NSArray *adArray) {
        [weakSelf assembleArray:normalArray ad:adArray target:target];
        weakSelf.needRefreshTableView = YES;
    }];
}

- (void)assembleArray:(NSArray *)normalArray ad:(NSArray *)adArray target:(NSString *)target
{
    [self.adArray removeAllObjects];
    [self.adArray addObjectsFromArray:adArray];

    if ([target isEqualToString:@"first"]){
        [self.listArray removeAllObjects];
        [self.listArray addObjectsFromArray:normalArray];
        //总数据
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:self.listArray];
        if(self.listArray.count > 0){
            for(SODynamicObject *object in self.adArray){
                NSInteger index = [object.displayPosition integerValue] - 1;
                [self.dataArray insertObject:object atIndex:index];
            }
        } else{
            [self.dataArray addObjectsFromArray:self.adArray];
        }
        [self insertRecomandArray];
        [self insertNewFriendArray];
        [self.newMessageNoticeView showWithText:[NSString stringWithFormat:@"为您加载了%ld条新动态",(long)self.dataArray.count]];
    } else if ([target isEqualToString:@"refresh"]){
        if (normalArray.count > 0){
            for (NSInteger i = normalArray.count - 1; i >= 0; i--){
                SODynamicObject *obj = [normalArray objectAtIndex:i];
                [self.listArray insertObject:obj atIndex:0];
            }
            [self.newMessageNoticeView showWithText:[NSString stringWithFormat:@"为您加载了%ld条新动态",(long)normalArray.count]];
        } else{
            [self.newMessageNoticeView showWithText:@"暂无新动态，休息一会儿"];
        }
        //总数据
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:self.listArray];

        if(self.listArray.count > 0){
            for(SODynamicObject *obj in self.adArray){
                NSInteger index = [obj.displayPosition integerValue] - 1;
                [self.dataArray insertObject:obj atIndex:index];
            }
        } else{
            [self.dataArray addObjectsFromArray:self.adArray];
        }
        [self insertRecomandArray];
        [self insertNewFriendArray];
    } else if ([target isEqualToString:@"load"]){
        [self.listArray addObjectsFromArray:normalArray];
        [self.dataArray addObjectsFromArray:normalArray];
    }
}

- (void)requestRecommendFriends
{
    [self.dataArray removeObject:self.recommendArray];
    [self.recommendArray removeAllObjects];
    WEAK(self, weakSelf);
    [SODynamicManager loadRecommendFriends:@{@"uid":KUID} block:^(NSArray *array) {
        [weakSelf.recommendArray addObjectsFromArray:array];
        [weakSelf insertRecomandArray];
    }];
}

- (void)loadRegisterPushFriend
{
    [self.dataArray removeObject:self.friendObject];
    self.friendObject = nil;
    WEAK(self, weakSelf);
    [SODynamicManager loadRegisterPushFriend:@{@"uid":KUID} block:^(SONewFriendObject *object) {
        weakSelf.friendObject = object;
        [weakSelf insertNewFriendArray];
    }];
}

- (void)insertRecomandArray
{
    if (self.recommendArray.count == 0 || [self.dataArray containsObject:self.recommendArray]) {
        return;
    }
    //第三个帖子后面
    if(self.dataArray.count > 5){
        [self.dataArray addObject:self.recommendArray];
        [self adjustAdditionalObject];
        self.needRefreshTableView = YES;
    }
}

- (void)insertNewFriendArray
{
    if (!self.friendObject || [self.dataArray containsObject:self.friendObject]) {
        return;
    }
    if(self.dataArray.count > 2){
        [self.dataArray addObject:self.friendObject];
        [self adjustAdditionalObject];
        self.needRefreshTableView = YES;
    }
}

//调整推荐好友和好友提醒的位置
- (void)adjustAdditionalObject
{
    if (self.dataArray.count > 5) {
        //移动提醒的位置
        if ([self.dataArray containsObject:self.friendObject]) {
            NSInteger index = [self.dataArray indexOfObject:self.friendObject];
            [self.dataArray moveObjectAtIndex:index toIndex:1];
        }

        //移动推荐的位置
        if ([self.dataArray containsObject:self.recommendArray]) {
            NSInteger index = [self.dataArray indexOfObject:self.recommendArray];
            if ([self.dataArray containsObject:self.friendObject]) {
                [self.dataArray moveObjectAtIndex:index toIndex:4];
            } else{
                [self.dataArray moveObjectAtIndex:index toIndex:3];
            }
        }
    }
}

- (void)refreshHeader
{
    if (self.dataArray.count > 0){
        [self loadDataWithTarget:@"refresh" dynamicID:[self refreshMaxRid]];
    } else{
        [self loadDataWithTarget:@"first" dynamicID:@"-1"];
    }
}

- (void)refreshFooter
{
    [self loadDataWithTarget:@"load" dynamicID:[self refreshMinRid]];
}

- (NSString *)refreshMaxRid
{
    NSString *dynamicID = @"";
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        SODynamicObject *object = [self.dataArray objectAtIndex:i];
        if([object isKindOfClass:[SODynamicObject class]]){
            if([object.postType isEqualToString:@"normal"] || [object.postType isEqualToString:@"normalpc"] || [object.postType isEqualToString:@"business"]){
                dynamicID = object.dynamicID;
                break;
            }
        }
    }
    return dynamicID;
}

- (NSString *)refreshMinRid
{
    NSString *dynamicID = @"";
    for(NSInteger i = self.dataArray.count - 1; i >= 0; i--){
        SODynamicObject *object = [self.dataArray objectAtIndex:i];
        if([object isKindOfClass:[SODynamicObject class]]){
            if([object.postType isEqualToString:@"normal"] || [object.postType isEqualToString:@"normalpc"] || [object.postType isEqualToString:@"business"]){
                dynamicID = object.dynamicID;
                break;
            }
        }
    }
    return dynamicID;
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
    NSObject *object = [self.dataArray objectAtIndex: indexPath.row];
    if([object isKindOfClass:[NSArray class]]){
        NSString *identifier1 = @"SORecommendTableViewCell";
        SORecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SORecommendTableViewCell" owner:self options:nil] lastObject];
        }
        cell.objectArray = (NSArray *)object;
        return cell;

    } else if ([object isKindOfClass:[SONewFriendObject class]]){

        NSString *identifier2 = @"SONewFriendTableViewCell";
        SONewFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (!cell){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SONewFriendTableViewCell" owner:self options:nil] lastObject];
        }
        cell.object = (SONewFriendObject *)object;
        return cell;

    } else {
        SODynamicObject *dynamicObject = (SODynamicObject *)object;
        if (![dynamicObject.postType isEqualToString:@"ad"]){
            if ([dynamicObject.status boolValue]){
                NSString *identifier3 = @"SOMainPageTableViewCell";
                SOMainPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
                if (!cell){
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"SOMainPageTableViewCell" owner:self options:nil] lastObject];
                }
                cell.object = dynamicObject;
                return cell;
            }
        } else{
            if ([dynamicObject.status boolValue]){
                NSString *identifier4 = @"SOExtendTableViewCell";
                SOExtendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier4];
                if (!cell){
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"SOExtendTableViewCell" owner:self options:nil] lastObject];
                }
                cell.object = dynamicObject;
                return cell;
            }
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
