//
//  RadioButtonView.h
//  RadioButton
//
//  Created by Terry on 2017/8/24.
//  Copyright © 2017年 zeaho. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RadioButtonViewDelegate <NSObject>

@optional
- (void)selectButtonWithIndex:(NSInteger)index title:(NSString *)title;

@end

@interface RadioButtonView : UIView

@property(nonatomic, weak) id <RadioButtonViewDelegate> delegate;

@property(nonatomic, assign) NSInteger selectedTag;

@property(nonatomic, assign) CGFloat font;

@property(nonatomic, assign) CGFloat horizontalPadding;

@property(nonatomic, assign) CGFloat verticalPadding;

@property(nonatomic, assign) CGFloat horizontalSpacing;

@property(nonatomic, assign) CGFloat verticalSpacing;

@property(nonatomic, strong) UIColor *selectColor;

@property(nonatomic, strong) UIColor *unSelectColor;

@property(nonatomic, strong) UIColor *unSelectBorderColor;

- (void)setButtonsWithTitles:(NSArray *)titles;

- (void)selectButtonWithIndex:(NSInteger)index;

- (void)updateButtonWithIndex:(NSInteger)index;

@end
