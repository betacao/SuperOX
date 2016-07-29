//
//  SOCategoryButton.h
//  Finance
//
//  Created by changxicao on 16/4/11.
//  Copyright © 2016年 HuMin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOCategoryButton : UIButton

@property (strong, nonatomic) id object;

@end

//必须先设置图片，再设置文字
@interface SOHorizontalTitleImageView : UIView

@property (assign, nonatomic) CGFloat margin;

- (void)addImage:(UIImage *)image;
- (void)addTitle:(NSString *)title;
- (void)target:(id)target addSeletor:(SEL)selector;

@end