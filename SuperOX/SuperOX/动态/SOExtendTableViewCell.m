//
//  SOExtendTableViewCell.m
//  Finance
//
//  Created by changxicao on 16/3/9.
//  Copyright © 2016年 HuMin. All rights reserved.
//

#import "SOExtendTableViewCell.h"
#import "SOMainPageConst.h"

@interface SOExtendTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *extendImageView;
//0.5的横线
@property (weak, nonatomic) IBOutlet UIView *lineView;
//灰色分割线
@property (weak, nonatomic) IBOutlet UIView *splitLine;

@end

@implementation SOExtendTableViewCell


- (void)initView
{
    self.titleLabel.font = kMainContentFont;
    self.titleLabel.textColor = kMainContentColor;

    self.markLabel.font = kMainTimeFont;
    self.markLabel.textColor = kMainTimeColor;
    self.markLabel.text = @"推广";

    self.timeLabel.font = kMainTimeFont;
    self.timeLabel.textColor = kMainTimeColor;

    self.lineView.backgroundColor = kMainLineViewColor;

    self.splitLine.backgroundColor = kMainSplitLineColor;

    self.extendImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)addAutoLayout
{
    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView, kMainItemLeftMargin)
    .topSpaceToView(self.contentView, 0.0f)
    .rightSpaceToView(self.contentView, kMainItemLeftMargin)
    .heightIs(MarginFactor(38.0f));

    self.extendImageView.sd_layout
    .leftEqualToView(self.titleLabel)
    .topSpaceToView(self.titleLabel, 0.0f)
    .rightEqualToView(self.titleLabel)
    .heightIs(MarginFactor(117.0f));

    self.markLabel.sd_layout
    .leftEqualToView(self.titleLabel)
    .topSpaceToView(self.extendImageView, MarginFactor(10.0f))
    .heightIs(self.markLabel.font.lineHeight);
    [self.markLabel setSingleLineAutoResizeWithMaxWidth:CGFLOAT_MAX];

    self.timeLabel.sd_layout
    .rightEqualToView(self.titleLabel)
    .topSpaceToView(self.extendImageView, MarginFactor(10.0f))
    .heightIs(self.timeLabel.font.lineHeight);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:CGFLOAT_MAX];

    self.lineView.sd_layout
    .leftSpaceToView(self.contentView, 0.0f)
    .rightSpaceToView(self.contentView, 0.0f)
    .topSpaceToView(self.timeLabel, MarginFactor(10.0f))
    .heightIs(0.5f);

    self.splitLine.sd_layout
    .leftSpaceToView(self.contentView, 0.0f)
    .rightSpaceToView(self.contentView, 0.0f)
    .topSpaceToView(self.lineView, 0.0f)
    .heightIs(kMainCellLineHeight);

    [self setupAutoHeightWithBottomView:self.splitLine bottomMargin:0.0f];
}

- (void)setObject:(SODynamicObject *)object
{
    _object = object;
    self.titleLabel.text = object.detail;
    NSURL *url = [NSURL URLWithString:[kApiPath stringByAppendingString:[object.attach firstObject]]];
    [self.extendImageView setImageWithURL:url placeholder:[UIImage imageNamed:@"default_image"]];
    self.timeLabel.text = object.publishDate;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
