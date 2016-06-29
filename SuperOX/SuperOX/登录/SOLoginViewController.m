//
//  SOLoginViewController.m
//  SuperOX
//
//  Created by changxicao on 16/5/23.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOLoginViewController.h"
#import "WXApi.h"

@interface SOLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textUser;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIButton *weChatButton;
@property (weak, nonatomic) IBOutlet UIButton *QQButton;
@property (weak, nonatomic) IBOutlet UIButton *weiBoButton;

@end

@implementation SOLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录/注册";
}

- (void)initView
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:KEY_PHONE]){
        self.textUser.text = [[NSUserDefaults standardUserDefaults]objectForKey:KEY_PHONE];
    }

    self.navigationItem.leftBarButtonItem = nil;
    self.view.backgroundColor = Color(@"efeeef");

    self.textUser.font = FontFactor(16.0f);
    self.textUser.textColor = Color(@"161616");

    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MarginFactor(12.0f), MarginFactor(55.0f))];
    self.textUser.leftView = leftView;
    self.textUser.leftViewMode = UITextFieldViewModeAlways;

    self.textUser.placeholder = @"请输入手机号";
    [self.textUser setValue:Color(@"afafaf") forKeyPath:@"_placeholderLabel.textColor"];
    [self.textUser setValue:FontFactor(16.0f) forKeyPath:@"_placeholderLabel.font"];

    self.introduceLabel.font = FontFactor(12.0f);
    self.introduceLabel.textColor = Color(@"989898");

    self.nextButton.titleLabel.font = FontFactor(16.0f);

    self.middleLabel.textColor = Color(@"9d9d9d");
    self.middleLabel.font = FontFactor(13.0f);

    self.leftView.backgroundColor = self.rightView.backgroundColor = Color(@"E6E7E8");
}

- (void)addAutoLayout
{
    self.textUser.sd_layout
    .leftSpaceToView(self.view, 0.0f)
    .rightSpaceToView(self.view, 0.0f)
    .topSpaceToView(self.view, 0.0f)
    .heightIs(MarginFactor(55.0f));

    self.introduceLabel.sd_layout
    .topSpaceToView(self.textUser, MarginFactor(10.0f))
    .leftSpaceToView(self.view, MarginFactor(12.0f))
    .rightSpaceToView(self.view, MarginFactor(12.0f))
    .autoHeightRatio(0.0f);

    self.nextButton.sd_layout
    .topSpaceToView(self.textUser, MarginFactor(181.0f))
    .leftEqualToView(self.introduceLabel)
    .rightEqualToView(self.introduceLabel)
    .heightIs(MarginFactor(40.0f));

    CGFloat margin = 0.0f;
    CGSize size = self.weChatButton.currentImage.size;
    if(![WXApi isWXAppSupportApi]){
        self.weChatButton.hidden = YES;
        margin = ceilf((SCREENWIDTH - 2 * size.width) / 3.0f);

        self.QQButton.sd_layout
        .bottomSpaceToView(self.view, MarginFactor(50.0f))
        .leftSpaceToView(self.view, margin)
        .widthIs(size.width)
        .heightIs(size.height);

        self.weiBoButton.sd_layout
        .centerYEqualToView(self.QQButton)
        .leftSpaceToView(self.QQButton, margin)
        .widthIs(size.width)
        .heightIs(size.height);

    } else{
        margin = ceilf((SCREENWIDTH - 3 * size.width) / 4.0f);

        self.QQButton.sd_layout
        .bottomSpaceToView(self.view, MarginFactor(50.0f))
        .centerXEqualToView(self.view)
        .widthIs(size.width)
        .heightIs(size.height);

        self.weChatButton.sd_layout
        .centerYEqualToView(self.QQButton)
        .rightSpaceToView(self.QQButton, margin)
        .widthIs(size.width)
        .heightIs(size.height);

        self.weiBoButton.sd_layout
        .centerYEqualToView(self.QQButton)
        .leftSpaceToView(self.QQButton, margin)
        .widthIs(size.width)
        .heightIs(size.height);
    }

    self.middleLabel.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.QQButton, MarginFactor(21.0f))
    .autoHeightRatio(0.0f);
    [self.middleLabel setSingleLineAutoResizeWithMaxWidth:CGFLOAT_MAX];

    self.leftView.sd_layout
    .rightSpaceToView(self.middleLabel, MarginFactor(14.0f))
    .centerYEqualToView(self.middleLabel)
    .widthIs(MarginFactor(125.0f))
    .heightIs(0.5f);

    self.rightView.sd_layout
    .leftSpaceToView(self.middleLabel, MarginFactor(14.0f))
    .centerYEqualToView(self.middleLabel)
    .widthIs(MarginFactor(125.0f))
    .heightIs(0.5f);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
