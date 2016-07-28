//
//  SOAlertView.h
//  Finance
//
//  Created by changxicao on 16/5/6.
//  Copyright © 2016年 HuMin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOAlertView : UIView

- (instancetype)initWithTitle:(NSString *)title contentText:(NSString *)content leftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rightTitle;
- (instancetype)initWithTitle:(NSString *)title customView:(UIView *)customView leftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rightTitle;
- (instancetype)initWithCustomView:(UIView *)customView leftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rightTitle;

- (void)addSubTitle:(NSString *)subTitle;
- (void)show;
- (void)showWithClose;

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;
@property (nonatomic, assign) BOOL shouldDismiss;
@property (nonatomic, assign) BOOL touchOtherDismiss;//点击黑色区域是否也消失

@end


@interface SOBusinessContactAlertView : SOAlertView

@property (strong, nonatomic) NSAttributedString *text;

- (instancetype)initWithLeftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rightTitle;

@end