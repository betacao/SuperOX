//
//  OMBaseViewController.m
//  OMNI
//
//  Created by changxicao on 16/5/13.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOBaseViewController.h"

@interface SOBaseViewController ()

@property (strong, nonatomic) UIImageView *bgImageView;
@property (strong, nonatomic) UIImageView *topImageView;

@end

@implementation SOBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self addAutoLayout];
    [self addReactiveCocoa];
    [self addLeftNavigationItem:nil normalImage:[UIImage imageNamed:@"common_backImage"] highlightedImage:nil];

    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:self.bgImageView];
    [self.view sendSubviewToBack:self.bgImageView];

    self.topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar_top_bg"]];
    [self.view insertSubview:self.topImageView aboveSubview:self.bgImageView];

    self.bgImageView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);

    self.topImageView.sd_layout.leftSpaceToView(self.view, 0.0f).rightSpaceToView(self.view, 0.0f).topSpaceToView(self.view, 0.0f).heightIs(self.topImageView.image.size.height);


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

- (void)addLeftNavigationItem:(NSString *)title normalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (normalImage) {
        [button setImage:normalImage forState:UIControlStateNormal];
    }
    if (highlightedImage) {
        [button setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }

    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)addRightNavigationItem:(NSString *)title normalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (normalImage) {
        [button setImage:normalImage forState:UIControlStateNormal];
    }
    if (highlightedImage) {
        [button setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)backButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClick:(UIButton *)button
{

}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
