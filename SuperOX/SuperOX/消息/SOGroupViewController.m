//
//  SOGroupViewController.m
//  SuperOX
//
//  Created by changxicao on 16/7/27.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOGroupViewController.h"
#import "SOSearchBar.h"
#import "SOChatViewController.h"
#import "SOCreateGroupViewController.h"
#import "SOGroupDetailViewController.h"

@interface SOGroupViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    BOOL isExpand[4];
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *recommendArray; //推荐群组
@property (strong, nonatomic) NSMutableArray *ownerArray; //我创建的群组
@property (strong, nonatomic) NSMutableArray *joinArray; // 我加入的群组
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) SOSearchBar *searchBar;

@end

@implementation SOGroupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initView
{
    self.tableView.backgroundColor = Color(@"efeeef");
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.tableFooterView = [[UIView alloc] init];

    self.searchBar = [[SOSearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"搜索";
    self.searchBar.cancelButtonTitleColor = Color(@"bebebe");

    self.ownerArray = [NSMutableArray array];
    self.joinArray = [NSMutableArray array];
    self.recommendArray = [NSMutableArray array];
}

- (void)addAutoLayout
{
    self.tableView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
}

- (void)loadData
{

    WEAK(self, weakSelf);
    [[EMClient sharedClient].groupManager asyncGetMyGroupsFromServer:^(NSArray *aList) {
        for (EMGroup *group in aList) {
            NSLog(@"%@", group.subject);
        }
        [aList enumerateObjectsUsingBlock:^(EMGroup *group, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([group.owner isEqualToString:KUID]) {
                [weakSelf.ownerArray addObject:group];
            } else {
                [weakSelf.joinArray addObject:group];
            }
        }];
        [weakSelf.tableView reloadData];
    } failure:nil];

    [[EMClient sharedClient].groupManager asyncGetPublicGroupsFromServerWithCursor:nil pageSize:-1 success:^(EMCursorResult *aCursor) {
        for (EMGroup *group in aCursor.list) {
            NSLog(@"%@", group.subject);
        }
        [weakSelf.recommendArray addObjectsFromArray:aCursor.list];
        [weakSelf.tableView reloadData];
    } failure:nil];
}

- (NSArray *)titleArray
{
    if (!_titleArray) {

        SOGroupHeaderObject *object0 = [[SOGroupHeaderObject alloc] init];
        object0.image = [UIImage imageNamed:@"message_arrowRight"];
        object0.text = @"推荐群组 (%ld)";

        SOGroupHeaderObject *object1 = [[SOGroupHeaderObject alloc] init];
        object1.image = [UIImage imageNamed:@"message_arrowRight"];
        object1.text = @"推荐群组 (%ld)";

        SOGroupHeaderObject *object2 = [[SOGroupHeaderObject alloc] init];
        object2.image = [UIImage imageNamed:@"message_arrowRight"];
        object2.text = @"我创建的群组 (%ld)";

        SOGroupHeaderObject *object3 = [[SOGroupHeaderObject alloc] init];
        object3.image = [UIImage imageNamed:@"message_arrowRight"];
        object3.text = @"我加入的群组 (%ld)";

        _titleArray = @[object0, object1, object2, object3];
    }
    return _titleArray;
}

- (void)SOGroupHeaderViewClick:(UITapGestureRecognizer *)recognizer
{
    SOGroupHeaderView *view = (SOGroupHeaderView *)recognizer.view;
    SOGroupHeaderObject *object = view.object;
    NSInteger index = [self.titleArray indexOfObject:object];
    isExpand[index] = !isExpand[index];
    NSIndexSet *set =[NSIndexSet indexSetWithIndex:index];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (isExpand[section] == YES){
        if  (section == 1){
            return [self.recommendArray count];
        } else if (section == 2){
            return [self.ownerArray count];
        } else if (section == 3){
            return [self.joinArray count];
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    SOGroupHeaderView *view = [[SOGroupHeaderView alloc] init];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SOGroupHeaderViewClick:)];
    [view addGestureRecognizer:recognizer];

    SOGroupHeaderObject *object = [self.titleArray objectAtIndex:section];
    if (isExpand[section] == YES){
        object.image = [UIImage imageNamed:@"message_arrowDown"];
    } else{
        object.image = [UIImage imageNamed:@"message_arrowRight"];
    }
    if (section == 1) {
        [SOGloble recordUserAction:@"" type:@"msg_recommendGroup"];
        object.count = self.recommendArray.count;
    } else if (section == 2){
        [SOGloble recordUserAction:@"" type:@"msg_createGroup"];
        object.count = self.ownerArray.count;
    } else{
        [SOGloble recordUserAction:@"" type:@"msg_joinGroup"];
        object.count = self.joinArray.count;
    }
    view.object = object;
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"SOGroupTableViewCell";
    SOGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    SOGroupObject *object = [[SOGroupObject alloc] init];
    switch (indexPath.section) {
        case 0:{
            object.text = @"新建群组";
            object.rightViewHidden = NO;
            object.lineViewHidden = NO;
            object.imageViewHidden = YES;
        }
            break;
        case 1:{
            EMGroup *group = [self.recommendArray objectAtIndex:indexPath.row];
            if (group.subject && group.subject.length > 0){
                object.text = group.subject;
            } else {
                object.text = group.groupId;
            }
            object.rightViewHidden = YES;
            object.lineViewHidden = NO;
            object.imageViewHidden = NO;
        }
            break;
        case 2:{
            EMGroup *group = [self.ownerArray objectAtIndex:indexPath.row];
            if (group.subject && group.subject.length > 0){
                object.text = group.subject;
            } else {
                object.text = group.groupId;
            }
            object.rightViewHidden = YES;
            object.lineViewHidden = NO;
            object.imageViewHidden = NO;
        }break;
        case 3:{
            EMGroup *group = [self.joinArray objectAtIndex:indexPath.row];
            if (group.subject && group.subject.length > 0){
                object.text = group.subject;
            } else {
                object.text = group.groupId;
            }
            object.rightViewHidden = YES;
            object.lineViewHidden = NO;
            object.imageViewHidden = NO;
        }break;
        default:{

        }
    }
    if (!cell){
        cell = [[SOGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.object = object;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MarginFactor(55.0f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    } else{
        return MarginFactor(55.0f);
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        SOCreateGroupViewController *controller = [[SOCreateGroupViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } else if (indexPath.section == 1){
        SOGroupDetailViewController *controller = [[SOGroupDetailViewController alloc] init];
        controller.group = [self.recommendArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];

    } else if (indexPath.section == 2){
        SOChatViewController *chatViewController = [[SOChatViewController alloc] init];
        chatViewController.group = [self.ownerArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:chatViewController animated:YES];

    } else if (indexPath.section == 3){
        SOChatViewController *chatViewController = [[SOChatViewController alloc] init];
        chatViewController.group = [self.joinArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:chatViewController animated:YES];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end


#pragma mark ------SOGroupObject
@implementation SOGroupObject



@end

#pragma mark ------SOGroupTableViewCell
@interface SOGroupTableViewCell()

@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIImageView *rightArrowView;

@end

@implementation SOGroupTableViewCell

- (void)initView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];

    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton setImage:[UIImage imageNamed:@"message_defaultImage"] forState:UIControlStateNormal];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = FontFactor(15.0f);
    self.titleLabel.textColor = Color(@"161616");

    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = Color(@"e6e7e8");

    self.rightArrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrowImage"]];

    [self.contentView addSubview:self.leftButton];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.rightArrowView];
}

- (void)addAutoLayout
{
    CGSize size = [UIImage imageNamed:@"message_defaultImage"].size;
    self.leftButton.sd_layout
    .leftSpaceToView(self.contentView, MarginFactor(12.0f))
    .centerYEqualToView(self.contentView)
    .widthIs(size.width)
    .heightIs(size.height);

    self.titleLabel.sd_layout
    .leftSpaceToView(self.leftButton, MarginFactor(10.0f))
    .centerYEqualToView(self.contentView)
    .autoHeightRatio(0.0f);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:CGFLOAT_MAX];

    self.lineView.sd_layout
    .leftEqualToView(self.leftButton)
    .rightSpaceToView(self.contentView, 0.0f)
    .heightIs(1 / SCALE)
    .bottomSpaceToView(self.contentView, 0.0f);

    size = [UIImage imageNamed:@"rightArrowImage"].size;
    self.rightArrowView.sd_layout
    .widthIs(size.width)
    .heightIs(size.height)
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, MarginFactor(11.0f));

}

- (void)setObject:(SOGroupObject *)object
{
    _object = object;
    self.titleLabel.frame = CGRectZero;
    self.titleLabel.text = object.text;
    self.lineView.hidden = object.lineViewHidden;
    self.rightArrowView.hidden = object.rightViewHidden;
    if (object.imageViewHidden) {
        [self.leftButton setImage:nil forState:UIControlStateNormal];
        self.titleLabel.sd_resetLayout
        .leftSpaceToView(self.contentView, MarginFactor(28.0f))
        .centerYEqualToView(self.contentView)
        .autoHeightRatio(0.0f);
    } else{
        [self.leftButton setImage:[UIImage imageNamed:@"message_defaultImage"] forState:UIControlStateNormal];
        self.titleLabel.sd_resetLayout
        .leftSpaceToView(self.leftButton, MarginFactor(10.0f))
        .centerYEqualToView(self.contentView)
        .autoHeightRatio(0.0f);
    }
}

@end


#pragma mark ------SOGroupHeaderView

@interface SOGroupHeaderView()
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *lineView;

@end

@implementation SOGroupHeaderView

- (void)initView
{
    self.backgroundColor = [UIColor whiteColor];

    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = FontFactor(15.0f);
    self.titleLabel.textColor = [UIColor colorWithHexString:@"161616"];

    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"e6e7e8"];

    [self addSubview:self.leftButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
}

- (void)addAutoLayout
{
    self.sd_layout
    .widthIs(SCREENWIDTH)
    .heightIs(MarginFactor(55.0f));

    UIImage *image = [UIImage imageNamed:@"message_arrowRight"];
    self.leftButton.sd_layout
    .leftSpaceToView(self, MarginFactor(12.0f))
    .centerYEqualToView(self)
    .widthIs(image.size.width)
    .heightIs(image.size.height);

    self.titleLabel.sd_layout
    .leftSpaceToView(self.leftButton, MarginFactor(9.0f))
    .centerYEqualToView(self)
    .autoHeightRatio(0.0f);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:CGFLOAT_MAX];

    self.lineView.sd_layout
    .leftEqualToView(self.leftButton)
    .rightSpaceToView(self, 0.0f)
    .heightIs(1 / SCALE)
    .bottomSpaceToView(self, 0.0f);

}

- (void)setObject:(SOGroupHeaderObject *)object
{
    _object = object;
    [self.leftButton setImage:object.image forState:UIControlStateNormal];

    self.titleLabel.text = [NSString stringWithFormat:object.text, (long)object.count];

}

@end

#pragma mark ------SOGroupHeaderObject
@implementation SOGroupHeaderObject



@end
