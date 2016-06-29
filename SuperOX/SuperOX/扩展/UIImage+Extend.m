//
//  UIImage+Extend.m
//  SuperOX
//
//  Created by changxicao on 16/6/28.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
