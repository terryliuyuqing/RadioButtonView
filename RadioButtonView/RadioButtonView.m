//
//  RadioButtonView.m
//  RadioButton
//
//  Created by Terry on 2017/8/24.
//  Copyright © 2017年 zeaho. All rights reserved.
//

#import "RadioButtonView.h"

@interface RadioButtonView ()

@property(nonatomic, strong) NSArray *buttonTitleArray;

@end

@implementation RadioButtonView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.font = 12.0f;
        self.horizontalPadding = 12.0f;
        self.verticalPadding = 6.0f;
        self.horizontalSpacing = 16.0f;
        self.verticalSpacing = 12.0f;
        self.selectColor = [UIColor greenColor];
        self.unSelectColor = [UIColor lightGrayColor];
        self.unSelectBorderColor = [UIColor lightGrayColor];
        self.selectedTag = 1;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self initUI];
}

- (void)setButtonsWithTitles:(NSArray *)titles {
    self.buttonTitleArray = [[NSArray alloc] initWithArray:titles];
}

- (void)initUI {
    for (UIButton *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    CGFloat totalWith = 0.0;
    CGFloat totalHeight = 0.0;
    NSInteger buttonTag = 1;

    for (NSString *text in self.buttonTitleArray) {
        CGRect textRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:self.font], NSFontAttributeName, nil] context:nil];
        CGSize textSize = textRect.size;
        textSize.width += self.horizontalPadding * 2;
        textSize.height += self.verticalPadding * 2;

        if ((totalWith + textSize.width) > self.frame.size.width) {
            totalHeight += textSize.height;
            totalHeight += self.verticalSpacing;
            totalWith = 0.0;
        }
        CGRect frame = CGRectMake(totalWith, totalHeight, textSize.width, textSize.height);
        UIButton *firstRadioButton = [self createRadioButtonWithFrame:frame
                                                                Title:text];
        firstRadioButton.tag = buttonTag;
        buttonTag++;
        totalWith += textSize.width;
        totalWith += self.horizontalSpacing;
    }
    
    UIButton *button = (UIButton *) [self viewWithTag:self.selectedTag];
    button.layer.borderColor = self.selectColor.CGColor;
    [button setTitleColor:self.selectColor forState:UIControlStateNormal];
}

- (UIButton *)createRadioButtonWithFrame:(CGRect)frame Title:(NSString *)title {
    UIButton *radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
    radioButton.frame = frame;
    radioButton.titleLabel.font = [UIFont systemFontOfSize:self.font];
    [radioButton setTitle:title forState:UIControlStateNormal];
    [radioButton setTitleColor:self.unSelectColor forState:UIControlStateNormal];
    radioButton.layer.borderWidth = 1;
    radioButton.layer.borderColor = self.unSelectBorderColor.CGColor;
    radioButton.layer.cornerRadius = 14;
//    radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [radioButton addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:radioButton];
    return radioButton;
}

- (void)selectedButton:(UIButton *)button {
    [self selectButtonWithIndex:button.tag];
}

- (void)selectButtonWithIndex:(NSInteger)index {
    [self updateButtonWithIndex:index];

    if (_delegate && [_delegate respondsToSelector:@selector(selectButtonWithIndex:title:)]) {
        [self.delegate selectButtonWithIndex:index title:self.buttonTitleArray[index - 1]];
    }
}

- (void)updateButtonWithIndex:(NSInteger)index {
    UIButton *btn = (UIButton *) [self viewWithTag:self.selectedTag];
    btn.layer.borderColor = self.unSelectBorderColor.CGColor;
    [btn setTitleColor:self.unSelectColor forState:UIControlStateNormal];
    
    self.selectedTag = index;
    UIButton *button = (UIButton *) [self viewWithTag:index];
    button.layer.borderColor = self.selectColor.CGColor;
    [button setTitleColor:self.selectColor forState:UIControlStateNormal];
}

@end
