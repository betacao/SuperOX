//
//  SOUserHeaderView.m
//  SuperOX
//
//  Created by changxicao on 16/7/27.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOUserHeaderView.h"

@interface SOUserHeaderView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSString *userId;

@end

@implementation SOUserHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];

    self.imageView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);


    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUserHeaderView)];
    [self addGestureRecognizer:recognizer];
}

- (void)updateHeaderView:(NSString *)sourceUrl userID:(NSString *)userId
{
    self.userId = userId;
    [self.imageView setImageWithURL:[NSURL URLWithString:sourceUrl] placeholder:[UIImage imageNamed:@"default_head"] options:kNilOptions completion:nil];
}

- (void)tapUserHeaderView
{
    if (self.userId) {
        [SOGloble recordUserAction:self.userId type:@"personalDynamic_index"];
    }
}

@end
