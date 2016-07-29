//
//  SOMessageSegmentViewController.m
//  SuperOX
//
//  Created by changxicao on 16/7/28.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOMessageSegmentViewController.h"
#import "SOGroupViewController.h"
#import "SOChatListViewController.h"

@interface SOMessageSegmentViewController ()

@property (strong, nonatomic) UIView *contentContainerView;
@property (strong, nonatomic) UISegmentedControl *segmentControl;

@end

@implementation SOMessageSegmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initView
{
    self.navigationItem.titleView = self.segmentControl;

    self.contentContainerView = [[UIView alloc] init];
    [self.view addSubview:self.contentContainerView];

    SOChatListViewController *chatListViewController = [[SOChatListViewController alloc] init];
    SOGroupViewController *groupViewController = [[SOGroupViewController alloc] init];
    self.viewControllers = @[chatListViewController, groupViewController];

    [self reloadTabButtons];
}

- (void)addAutoLayout
{
    self.contentContainerView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
}

- (UISegmentedControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"消息", @"群组"]];
        [_segmentControl setWidth:MarginFactor(85.0f) forSegmentAtIndex:0];
        [_segmentControl setWidth:MarginFactor(85.0f) forSegmentAtIndex:1];
        _segmentControl.layer.masksToBounds = YES;
        _segmentControl.layer.cornerRadius = 4.0f;
        _segmentControl.tintColor = [UIColor clearColor];
        _segmentControl.layer.borderColor =  [UIColor whiteColor].CGColor;
        _segmentControl.layer.borderWidth = 1.0;
        _segmentControl.selected = NO;
        _segmentControl.selectedSegmentIndex = 0;

        //设置标题的颜色 字体和大小 阴影和阴影颜色
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,FontFactor(15.0f),NSFontAttributeName ,nil];
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"d53432"],NSForegroundColorAttributeName,FontFactor(15.0f),NSFontAttributeName ,nil];
        [_segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
        [_segmentControl setTitleTextAttributes:dic1 forState:UIControlStateSelected];
        
        UIImage *normalImage = [UIImage imageWithColor:Color(@"d53432") size:CGSizeMake(MarginFactor(85.0f), CGRectGetHeight(_segmentControl.frame))];
        UIImage *selectedImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(MarginFactor(85.0f), CGRectGetHeight(_segmentControl.frame))];
        [_segmentControl setBackgroundImage:normalImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [_segmentControl setBackgroundImage:normalImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [_segmentControl setBackgroundImage:selectedImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

        [_segmentControl addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _segmentControl;
}

- (void)setViewControllers:(NSArray *)newViewControllers
{
    NSAssert([newViewControllers count] >= 2, @"MHTabBarController requires at least two view controllers");
    UIViewController *oldSelectedViewController = self.selectedViewController;

    for (UIViewController *viewController in self.viewControllers){
        [viewController removeFromParentViewController];
    }
    _viewControllers = newViewControllers;

    NSUInteger newIndex = [self.viewControllers indexOfObject:oldSelectedViewController];
    if (newIndex != NSNotFound)
        _selectedIndex = newIndex;
    else if (newIndex < [self.viewControllers count])
        _selectedIndex = newIndex;
    else
        _selectedIndex = 0;

    for (UIViewController *viewController in self.viewControllers){
        [self addChildViewController:viewController];
    }

    if ([self isViewLoaded]){
        [self reloadTabButtons];
    }
}


- (void)reloadTabButtons
{
    NSUInteger lastIndex = _selectedIndex;
    _selectedIndex = NSNotFound;
    self.selectedIndex = lastIndex;
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex
{
    [self setSelectedIndex:newSelectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex animated:(BOOL)animated
{
    NSAssert(newSelectedIndex < [self.viewControllers count], @"View controller index out of bounds");

    if (![self isViewLoaded]) {
        _selectedIndex = newSelectedIndex;
    } else if (_selectedIndex != newSelectedIndex) {
        UIViewController *fromViewController;
        UIViewController *toViewController;

        if (_selectedIndex != NSNotFound) {
            fromViewController = self.selectedViewController;
        }

        NSUInteger oldSelectedIndex = _selectedIndex;
        _selectedIndex = newSelectedIndex;

        if (_selectedIndex != NSNotFound) {
            toViewController = self.selectedViewController;
        }

        if (toViewController == nil) {
            [fromViewController.view removeFromSuperview];
        } else if (fromViewController == nil) {
            toViewController.view.frame = self.contentContainerView.bounds;
            [self.contentContainerView addSubview:toViewController.view];
        } else if (animated) {
            CGRect rect = self.contentContainerView.bounds;
            if (oldSelectedIndex < newSelectedIndex) {
                rect.origin.x = rect.size.width;
            } else {
                rect.origin.x = -rect.size.width;
            }

            toViewController.view.frame = rect;
            self.segmentControl.userInteractionEnabled = NO;

            [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.3f options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut animations:^{
                CGRect rect = fromViewController.view.frame;
                if (oldSelectedIndex < newSelectedIndex){
                    rect.origin.x = -rect.size.width;
                } else{
                    rect.origin.x = rect.size.width;
                }
                fromViewController.view.frame = rect;
                toViewController.view.frame = self.contentContainerView.bounds;
            } completion:^(BOOL finished){
                self.segmentControl.userInteractionEnabled = YES;
            }];
        } else{
            [fromViewController.view removeFromSuperview];
            toViewController.view.frame = self.contentContainerView.bounds;
            [self.contentContainerView addSubview:toViewController.view];
        }
    }
}

- (UIViewController *)selectedViewController
{
    if (self.selectedIndex != NSNotFound) {
        return [self.viewControllers objectAtIndex:self.selectedIndex];
    } else {
        return nil;
    }
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController
{
    [self setSelectedViewController:newSelectedViewController animated:NO];
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController animated:(BOOL)animated;
{
    NSUInteger index = [self.viewControllers indexOfObject:newSelectedViewController];
    if (index != NSNotFound) {
        [self setSelectedIndex:index animated:animated];
    }
}

- (void)valueChange:(UISegmentedControl *)seg
{
    [self setSelectedIndex:seg.selectedSegmentIndex animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
