//
//  SYProgressHUD.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/19.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYProgressHUD : NSObject


/// 添加到window窗口
/// @param message 提示信息
+ (void)progressMessage:(NSString *)message;

/// 添加到指定视图
/// @param view 指定视图
/// @param message 提示信息
+ (void)progressView:(UIView *)view Message:(NSString *)message;

/// 添加到window窗口 正确
/// @param message 提示信息
+ (void)messageSuccess:(NSString *)message;

/// 添加到window窗口 错误
/// @param message 提示信息
+ (void)messageError:(NSString *)message;

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD;
/**
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *_Nullable)view;


@end

NS_ASSUME_NONNULL_END
