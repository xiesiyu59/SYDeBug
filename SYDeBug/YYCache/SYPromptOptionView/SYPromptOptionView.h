//
//  SYPromptOptionView.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/7/17.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYPromptOptionView : UIView


/// 默认从顶部弹出
/// @param content 内容
/// @param successTitle 成功标题
/// @param successBlock 成功事件
/// @param cancelTitle 失败标题
/// @param cancelBlock 失败事件
+ (void)showWithContentStr:(NSString *)content
              successTitle:(NSString *)successTitle
              successBlock:(void (^__nullable)(void ))successBlock
               cancelTitle:(NSString *)cancelTitle
               cancelBlock:(void (^__nullable)(void ))cancelBlock;

/// 从底部弹出
/// @param content 内容
/// @param successTitle 成功标题
/// @param successBlock 成功事件
/// @param cancelTitle 失败标题
/// @param cancelBlock 失败事件
+ (void)showWithBottomContentStr:(NSString *)content
                    successTitle:(NSString *)successTitle
                    successBlock:(void (^__nullable)(void ))successBlock
                     cancelTitle:(NSString *)cancelTitle
                     cancelBlock:(void (^__nullable)(void ))cancelBlock;


@end

NS_ASSUME_NONNULL_END
