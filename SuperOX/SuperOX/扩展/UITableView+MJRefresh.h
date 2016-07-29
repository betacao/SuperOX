//
//  UITableView+MJRefresh.h
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (MJRefresh)

- (void)addHeaderRefesh:(BOOL)isHeaderFresh andFooter:(BOOL)isFooterRefresh footerTitle:(NSDictionary *)footerTitle;

@end


@interface SOGifHeader : MJRefreshHeader

@end