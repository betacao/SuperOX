//
//  SOCreateGroupViewController.m
//  SuperOX
//
//  Created by changxicao on 16/7/28.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOCreateGroupViewController.h"
#import "SOTextView.h"

@interface SOCreateGroupViewController ()<UITextViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UIView *mainFieldView;
@property (strong, nonatomic) UIView *mainTextView;
@property (strong, nonatomic) UIView *switchView;
@property (strong, nonatomic) UIView *fieldTopLine;
@property (strong, nonatomic) UIView *fieldBottomLine;
@property (strong, nonatomic) UIView *viewTopLine;
@property (strong, nonatomic) UIView *viewBottomLine;
@property (strong, nonatomic) UIView *switchTopLine;
@property (strong, nonatomic) UIView *switchBottomLine;

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) SOTextView *textView;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UISwitch *switchControl;
@property (strong, nonatomic) UIButton *button;

@property (assign, nonatomic) BOOL isMemberOn;

@end

@implementation SOCreateGroupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initView
{
    self.title = @"创建群组";
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = Color(@"F2F2F2");
}

- (void)addAutoLayout
{
    self.mainFieldView.sd_layout
    .topSpaceToView(self.scrollView, MarginFactor(10.0f))
    .leftSpaceToView(self.scrollView, 0.0f)
    .rightSpaceToView(self.scrollView, 0.0f)
    .heightIs(MarginFactor(45.0f));

    self.mainTextView.sd_layout
    .topSpaceToView(self.mainFieldView, MarginFactor(10.0f))
    .leftEqualToView(self.mainFieldView)
    .rightEqualToView(self.mainFieldView)
    .heightIs(MarginFactor(82.0f));

    self.switchView.sd_layout
    .topSpaceToView(self.mainTextView, MarginFactor(10.0f))
    .leftEqualToView(self.mainTextView)
    .rightEqualToView(self.mainTextView)
    .heightIs(MarginFactor(45.0f));

    self.button.sd_layout
    .leftSpaceToView(self.scrollView, MarginFactor(15.0f))
    .rightSpaceToView(self.scrollView, MarginFactor(15.0f))
    .bottomSpaceToView(self.scrollView, MarginFactor(12.0f))
    .heightIs(MarginFactor(40.0f));

    self.textField.sd_layout
    .leftSpaceToView(self.mainFieldView, MarginFactor(12.0f))
    .topSpaceToView(self.mainFieldView, 0.0f)
    .rightSpaceToView(self.mainFieldView, MarginFactor(12.0f))
    .bottomSpaceToView(self.mainFieldView, 0.0f);

    self.textView.sd_layout
    .leftSpaceToView(self.mainTextView,MarginFactor(8.0f))
    .topSpaceToView(self.mainTextView, 0.0f)
    .rightSpaceToView(self.mainTextView, MarginFactor(12.0f))
    .bottomSpaceToView(self.mainTextView, 0.0f);

    self.label.sd_layout
    .leftSpaceToView(self.switchView, MarginFactor(12.0f))
    .topSpaceToView(self.switchView, 0.0f)
    .widthIs(MarginFactor(160.0f))
    .heightIs(MarginFactor(45.0f));

    self.switchControl.sd_layout
    .rightSpaceToView(self.switchView, MarginFactor(12.0f))
    .centerYEqualToView(self.label);

    self.fieldTopLine.sd_layout
    .topSpaceToView(self.mainFieldView, 0.0f)
    .leftSpaceToView(self.mainFieldView, 0.0f)
    .rightSpaceToView(self.mainFieldView, 0.0f)
    .heightIs(1 / SCALE);

    self.viewTopLine.sd_layout
    .topSpaceToView(self.mainTextView, 0.0f)
    .leftSpaceToView(self.mainTextView, 0.0f)
    .rightSpaceToView(self.mainTextView, 0.0f)
    .heightIs(1 / SCALE);

    self.switchTopLine.sd_layout
    .topSpaceToView(self.switchView, 0.0f)
    .leftSpaceToView(self.switchView, 0.0f)
    .rightSpaceToView(self.switchView, 0.0f)
    .heightIs(1 / SCALE);

    self.fieldBottomLine.sd_layout
    .bottomSpaceToView(self.mainFieldView, 0.0f)
    .leftSpaceToView(self.mainFieldView, 0.0f)
    .rightSpaceToView(self.mainFieldView, 0.0f)
    .heightIs(1 / SCALE);

    self.viewBottomLine.sd_layout
    .bottomSpaceToView(self.mainTextView, 0.0f)
    .leftSpaceToView(self.mainTextView, 0.0f)
    .rightSpaceToView(self.mainTextView, 0.0f)
    .heightIs(1 / SCALE);

    self.switchBottomLine.sd_layout
    .bottomSpaceToView(self.switchView, 0.0f)
    .leftSpaceToView(self.switchView, 0.0f)
    .rightSpaceToView(self.switchView, 0.0f)
    .heightIs(1 / SCALE);
}

- (UIView *)mainFieldView
{
    if (!_mainFieldView) {
        _mainFieldView = [[UIView alloc] init];
        _mainFieldView.backgroundColor = [UIColor whiteColor];
        _fieldTopLine = [[UIView alloc]init];
        _fieldTopLine.backgroundColor = [UIColor colorWithHexString:@"e7e5e7"];
        [_mainFieldView addSubview:_fieldTopLine];
        _fieldBottomLine = [[UIView alloc]init];
        _fieldBottomLine.backgroundColor = [UIColor colorWithHexString:@"e7e5e7"];
        [_mainFieldView addSubview:_fieldBottomLine];

        [self.scrollView addSubview:_mainFieldView];
    }
    return _mainFieldView;
}

- (UIView *)mainTextView
{
    if (!_mainTextView) {
        _mainTextView = [[UIView alloc] init];
        _mainTextView.backgroundColor = [UIColor whiteColor];
        _viewTopLine = [[UIView alloc] init];
        _viewTopLine.backgroundColor = [UIColor colorWithHexString:@"e7e5e7"];
        [_mainTextView addSubview:_viewTopLine];
        _viewBottomLine = [[UIView alloc] init];
        _viewBottomLine.backgroundColor = [UIColor colorWithHexString:@"e7e5e7"];
        [_mainTextView addSubview:_viewBottomLine];
        [self.scrollView addSubview:_mainTextView];
    }
    return _mainTextView;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.textColor = [UIColor colorWithHexString:@"606060"];
        _textField.font = FontFactor(15.0f);
        _textField.backgroundColor = [UIColor clearColor];
        _textField.placeholder = @"请输入群组名称";
        _textField.returnKeyType = UIReturnKeyDone;
        [_textField setValue:[UIColor colorWithHexString:@"D3D3D3"] forKeyPath:@"_placeholderLabel.textColor"];
        _textField.delegate = self;
        [self.mainFieldView addSubview:_textField];
    }
    return _textField;
}

- (SOTextView *)textView
{
    if (!_textView ) {
        _textView = [[SOTextView alloc] init];
        _textView.textColor = [UIColor colorWithHexString:@"606060"];
        _textView.font = FontFactor(15.0f);
        _textView.placeholder = @"请输入群组简介（150字）";
        _textView.placeholderColor = Color(@"d3d3d3");
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.delegate = self;
        [self.mainTextView addSubview:_textView];
    }
    return _textView;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setBackgroundColor:[UIColor colorWithHexString:@"f04241"]];
        [_button setTitle:@"保存" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(addContacts:) forControlEvents:UIControlEventTouchUpInside];
        _button.titleLabel.font = FontFactor(15.0f);
        [self.scrollView addSubview:_button];
    }
    return _button;
}

- (UIView *)switchView
{
    if (!_switchView) {
        _switchView = [[UIView alloc] init];
        _switchView.backgroundColor = [UIColor whiteColor];
        _switchTopLine = [[UIView alloc]init];
        _switchTopLine.backgroundColor = [UIColor colorWithHexString:@"e7e5e7"];
        [_switchView addSubview:_switchTopLine];
        _switchBottomLine = [[UIView alloc]init];
        _switchBottomLine.backgroundColor = [UIColor colorWithHexString:@"e7e5e7"];
        [_switchView addSubview:_switchBottomLine];
        [self.scrollView addSubview:_switchView];
    }

    return _switchView;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = FontFactor(15.0f);
        _label.backgroundColor = [UIColor clearColor];
        _label.text = @"开放群成员邀请";
        _label.textColor = [UIColor colorWithHexString:@"606060"];
        [self.switchView addSubview:_label];
    }
    return _label;
}

- (UISwitch *)switchControl
{
    if (!_switchControl) {
        _switchControl = [[UISwitch alloc] init];
        [_switchControl addTarget:self action:@selector(groupMemberChange:) forControlEvents:UIControlEventValueChanged];
        [self.switchView addSubview:_switchControl];
    }
    return _switchControl;
}


- (void)groupMemberChange:(UISwitch *)control
{
    _isMemberOn = control.isOn;
}

- (void)addContacts:(id)sender
{
    if (self.textField.text.length == 0) {
        [self.scrollView showWithText:@"群组名称不能为空"];
        return;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString *toBeString = textView.text;
    //获取高亮部分
    UITextRange *selectedRange = textView.markedTextRange;
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];

    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (toBeString.length > 150) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:150];
            if (rangeIndex.length == 1) {
                textView.text = [toBeString substringToIndex:150];
            } else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 150)];
                textView.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textView resignFirstResponder];
    [self.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
