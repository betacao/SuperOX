//
//  SOLoginNextViewController.m
//  SuperOX
//
//  Created by changxicao on 16/6/29.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOLoginNextViewController.h"
#import "SOLoginManager.h"
#import "SOBaseNavigationViewController.h"

@interface SOLoginNextViewController ()

@property (weak, nonatomic) IBOutlet UITextField *lblPassward;
@property (weak, nonatomic) IBOutlet UIButton *forgetPassward;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation SOLoginNextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initView
{
    self.title = @"输入密码";
    self.view.backgroundColor = Color(@"efeeef");

    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, MarginFactor(12.0f), MarginFactor(55.0f))];
    self.lblPassward.leftView = leftView;
    self.lblPassward.leftViewMode = UITextFieldViewModeAlways;

    [self.lblPassward setValue:[UIColor colorWithHexString:@"AFAFAF"] forKeyPath:@"_placeholderLabel.textColor"];
    self.lblPassward.font = FontFactor(16.0f);
    self.lblPassward.textColor = [UIColor colorWithHexString:@"161616"];

    [self.forgetPassward setTitleColor:[UIColor colorWithHexString:@"989898"] forState:UIControlStateNormal];
    self.forgetPassward.titleLabel.font = FontFactor(12.0f);
    [self.loginButton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [self.loginButton setBackgroundColor:[UIColor colorWithHexString:@"f04241"]];
    self.loginButton.titleLabel.font = FontFactor(17.0f);
    self.lblPassward.text = @"111111";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.lblPassward becomeFirstResponder];
}

- (void)addAutoLayout
{
    self.lblPassward.sd_layout
    .topSpaceToView(self.view, 0.0f)
    .leftSpaceToView(self.view, 0.0f)
    .rightSpaceToView(self.view, 0.0f)
    .heightIs(MarginFactor(55.0f));

    self.forgetPassward.sd_layout
    .topSpaceToView(self.lblPassward, MarginFactor(10.0f))
    .rightSpaceToView(self.view, 0.0f)
    .widthIs(MarginFactor(80.0f))
    .heightIs(MarginFactor(15.0f));

    self.loginButton.sd_layout
    .leftSpaceToView(self.view, MarginFactor(12.0f))
    .rightSpaceToView(self.view, MarginFactor(12.0f))
    .topSpaceToView(self.lblPassward, MarginFactor(181.0f))
    .heightIs(MarginFactor(40.0f));

}

- (void)addReactiveCocoa
{
    [[[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] filter:^BOOL(id value) {
        if (IsStringEmpty(self.lblPassward.text)){
            [self.view showWithText:@"请输入密码"];
            return NO;
        }
        return YES;
    }] subscribeNext:^(id x) {
        [SOLoginManager login:self.lblPassward.text inView:self.view complete:^(BOOL success) {
            SOTabbarViewController *controller = [SOTabbarViewController sharedController];
            SOBaseNavigationViewController *navigationViewController = [[SOBaseNavigationViewController alloc] initWithRootViewController:controller];
            [self presentViewController:navigationViewController animated:YES completion:nil];
        }];
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self.lblPassward resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
