//
//  UITextView+Placeholder.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/14.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (Placeholder) <UITextViewDelegate>

//placeHolder
@property (nonatomic, strong) UITextView *syPlaceholderTextView;

- (void)syAddPlaceholder:(NSString *)placeholder;

// limit 限制输入
@property (assign, nonatomic)  NSInteger syMaxLength;//if <=0, no limit

// 设置行间距， 默认调整是5
- (instancetype)setupAttributedText:(NSString *)text;


@end

NS_ASSUME_NONNULL_END
