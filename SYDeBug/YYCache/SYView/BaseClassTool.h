//
//  BaseClassTool.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/7/17.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseClassTool : NSObject

+ (UIView *)backView;
+ (UIView *)lineView;

+ (UILabel *)labelWithFont:(CGFloat)font
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)textAlignment;

+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                                   font:(CGFloat)font
                             titleColor:(UIColor *)titleColor
             contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
                                  title:(NSString *)title;

+ (UIButton *)buttonWithFont:(CGFloat)font
                  titleColor:(UIColor *)titleColor
  contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
                       title:(NSString *)title;

+ (UITextField *)textFieldWithFont:(CGFloat)font
                         textColor:(UIColor *)textColor
                      keyboardType:(UIKeyboardType)keyboardType
                     returnKeyType:(UIReturnKeyType)returnKeyType
                       placeholder:(NSString *)placeholder
                              text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
