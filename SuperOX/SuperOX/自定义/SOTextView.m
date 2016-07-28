//
//  SOTextView.m
//  SuperOX
//
//  Created by changxicao on 16/7/28.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOTextView.h"

@implementation SOTextView

- (id)init
{
    self = [super init];
    if (self) {
        self.contentColor = [UIColor blackColor];
        self.placeholderColor = [UIColor colorWithHexString:@"d3d3d3"];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    }
    return self;
}

- (void)awakeFromNib
{
    self.contentColor = [UIColor blackColor];
    self.placeholderColor = [UIColor colorWithHexString:@"d3d3d3"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

#pragma mark - super

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    self.contentColor = textColor;
}

- (NSString *)text
{
    if ([super.text isEqualToString:self.placeholder]) {
        return @"";
    }
    return [super text];
}

- (void)setText:(NSString *)string
{
    super.textColor = self.contentColor;
    [super setText:string];
}

#pragma mark - setting

- (void)setPlaceholder:(NSString *)string
{
    _placeholder = string;
}

- (void)setPlaceholderColor:(UIColor *)color
{
    _placeholderColor = color;
}

#pragma mark - notification
- (void)startEditing:(NSNotification *)notification
{
    if ([super.text isEqualToString:self.placeholder]) {
        super.textColor = self.contentColor;
        super.text = @"";
    }
}

- (void)finishEditing:(NSNotification *)notification
{
    if (super.text.length == 0) {
        super.textColor = self.placeholderColor;
        super.text = self.placeholder;
    } else {
        super.textColor = self.contentColor;
    }
}

@end
