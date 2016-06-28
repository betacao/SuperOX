//
//  SOBaseView.m
//  SuperOX
//
//  Created by changxicao on 16/6/28.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOBaseView.h"

@implementation SOBaseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
        [self addAutoLayout];
        [self addReactiveCocoa];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initView];
    [self addAutoLayout];
    [self addReactiveCocoa];
}


- (void)initView
{

}

- (void)addAutoLayout
{

}

- (void)addReactiveCocoa
{

}


@end
