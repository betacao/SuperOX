//
//  SOAuthenticationView.h
//  Finance
//
//  Created by changxicao on 16/6/23.
//  Copyright © 2016年 HuMin. All rights reserved.
//

#import "SOBaseView.h"

@interface SOAuthenticationView : SOBaseView

@property (assign, nonatomic) BOOL showGray;

@property (nonatomic, copy) dispatch_block_t block;

- (void)initView;
- (void)addAutoLayout;
- (void)updateWithVStatus:(BOOL)vStatus enterpriseStatus:(BOOL)enterpriseStatus;

@end
