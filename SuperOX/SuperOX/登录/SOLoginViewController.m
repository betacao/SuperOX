//
//  SOLoginViewController.m
//  SuperOX
//
//  Created by changxicao on 16/5/23.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOLoginViewController.h"
#import "SOLoginManager.h"
#import "SOLoginNextViewController.h"
#import "SORegisterViewController.h"
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
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)initView
{
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

    self.view.backgroundColor = Color(@"efeeef");

    self.textUser.text = [[NSUserDefaults standardUserDefaults]objectForKey:KEY_PHONE];
    
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

- (void)addReactiveCocoa
{
    [[[self.nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] filter:^BOOL(id value) {
        if (IsStringEmpty(self.textUser.text)) {
            [self.view showWithText:@"手机号码不能为空"];
            return NO;
        }
        if (![self.textUser.text isValidateMobile]) {
            [self.view showWithText:@"手机号码不合法"];
            return NO;
        }
        return YES;
    }] subscribeNext:^(id x) {
        [SOLoginManager validate:self.textUser.text inView:self.view complete:^(BOOL success) {
            if (success) {
                SOLoginNextViewController *controller = [[SOLoginNextViewController alloc] init];
                [self.navigationController pushViewController:controller animated:YES];
            } else{
                SORegisterViewController *controller = [[SORegisterViewController alloc] init];
                [self.navigationController pushViewController:controller animated:YES];
            }
        }];
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textUser resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
