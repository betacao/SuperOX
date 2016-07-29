//
//  UITableView+MJRefresh.m
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "UITableView+MJRefresh.h"
#import "SOProgressHUD.h"

@implementation UITableView (MJRefresh)

- (void)addHeaderRefesh:(BOOL)isHeaderFresh andFooter:(BOOL)isFooterRefresh footerTitle:(NSDictionary *)footerTitle
{
    if (isHeaderFresh){
        SOGifHeader *header = [SOGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
        header.backgroundColor = [UIColor whiteColor];
        self.mj_header = header;
    }
    if (isFooterRefresh){
        MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
        footer.stateLabel.textColor = [UIColor colorWithHexString:@"606060"];
        footer.stateLabel.font = FontFactor(12.0f);
        [footer setTitle:[footerTitle objectForKey:@(MJRefreshStateIdle)] forState:MJRefreshStateIdle];
        [footerTitle enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSString *obj, BOOL * _Nonnull stop) {
            [footer setTitle:obj forState:key.integerValue];
        }];
        self.mj_footer = footer;
    }
}

- (void)refreshHeader
{

}

- (void)refreshFooter
{
    
}


@end

@interface SOGifHeader ()

@property (strong, nonatomic) SOProgressHUD *progressHud;

@end

@implementation SOGifHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];

    // 设置控件的高度
    self.mj_h = MJRefreshHeaderHeight;
    self.progressHud = [[SOProgressHUD alloc] init];
    self.progressHud.shouldAutoMediate = NO;
    [self addSubview:self.progressHud];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];

}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];

}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    [super setState:state];
    switch (state) {
        case MJRefreshStateIdle:
            [self.progressHud startAnimation];
            break;
        case MJRefreshStatePulling:
            [self.progressHud startAnimation];
            break;
        case MJRefreshStateRefreshing:
            [self.progressHud startAnimation];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}


@end