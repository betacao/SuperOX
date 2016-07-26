//
//  SOEmptyDataView.h
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOBaseView.h"

typedef NS_ENUM(NSInteger, SOEmptyDateType) {
    SOEmptyDateNormal = 0,//普通的无数据
    SOEmptyDateMarketDeleted = 1,
    SOEmptyDateBusinessDeleted = 2,
    SOEmptyDateDiscoverySearch = 3
};

@interface SOEmptyDataView : SOBaseView

@property (assign, nonatomic) SOEmptyDateType type;

@end



