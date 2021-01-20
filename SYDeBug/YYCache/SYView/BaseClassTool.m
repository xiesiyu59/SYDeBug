//
//  BaseClassTool.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/7/17.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "BaseClassTool.h"

@implementation BaseClassTool


+ (UILabel *)labelWithFont:(CGFloat)font
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    return label;
}

+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                                   font:(CGFloat)font
                             titleColor:(UIColor *)titleColor
             contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
                                  title:(NSString *)title {
    UIButton *button = [self buttonWithFont:font
                                 titleColor:titleColor
                 contentHorizontalAlignment:contentHorizontalAlignment
                                      title:title];
    button.backgroundColor = backgroundColor;
    button.layer.cornerRadius = 4;
    return button;
}

+ (UIButton *)buttonWithFont:(CGFloat)font
                  titleColor:(UIColor *)titleColor
  contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
                       title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitleColor:titleColor
                 forState:UIControlStateNormal];
    button.contentHorizontalAlignment = contentHorizontalAlignment;
    [button setTitle:title
            forState:UIControlStateNormal];
    return button;
}

+ (UITextField *)textFieldWithFont:(CGFloat)font
                         textColor:(UIColor *)textColor
                      keyboardType:(UIKeyboardType)keyboardType
                     returnKeyType:(UIReturnKeyType)returnKeyType
                       placeholder:(NSString *)placeholder
                              text:(NSString *)text {
    UITextField *textField = [[UITextField alloc] init];
    textField.font = [UIFont systemFontOfSize:font];
    textField.textColor = textColor;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.keyboardType = keyboardType;
    textField.returnKeyType = returnKeyType;
    textField.placeholder = placeholder;
    textField.text = text;
    return textField;
}

@end
