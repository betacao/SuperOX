//
//  SOEmptyDataView.m
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOEmptyDataView.h"

@interface SOEmptyDataView()

@property (strong, nonatomic) UIImageView *imageView;

@end


@implementation SOEmptyDataView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"EFEEEF"];
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        self.type = SOEmptyDateNormal;
    }
    return self;
}

- (void)setType:(SOEmptyDateType)type
{
    _type = type;
    switch (type) {
        case SOEmptyDateNormal:
            self.imageView.image = [UIImage imageNamed:@"emptyBg"];
            self.imageView.sd_layout
            .centerXEqualToView(self)
            .centerYEqualToView(self)
            .widthIs(self.imageView.image.size.width)
            .heightIs(self.imageView.image.size.height);
            break;
        case SOEmptyDateMarketDeleted:
            self.imageView.image = [UIImage imageNamed:@"deleted_market"];
            self.imageView.sd_layout
            .centerXEqualToView(self)
            .centerYEqualToView(self)
            .widthIs(self.imageView.image.size.width)
            .heightIs(self.imageView.image.size.height);
            break;
        case SOEmptyDateBusinessDeleted:
            self.imageView.image = [UIImage imageNamed:@"deleted_market"];
            self.imageView.sd_layout
            .centerXEqualToView(self)
            .centerYEqualToView(self)
            .widthIs(self.imageView.image.size.width)
            .heightIs(self.imageView.image.size.height);
            break;
        case SOEmptyDateDiscoverySearch:
            self.backgroundColor = [UIColor whiteColor];
            self.imageView.image = [UIImage imageNamed:@"discovery_search_none"];
            self.imageView.sd_layout
            .centerXEqualToView(self)
            .topSpaceToView(self, MarginFactor(65.0f))
            .widthIs(self.imageView.image.size.width)
            .heightIs(self.imageView.image.size.height);
            break;
        default:
            break;
    }
}

- (void)didMoveToSuperview
{
    if (self.superview) {
        self.sd_layout
        .spaceToSuperView(UIEdgeInsetsZero);
    }
}
@end
