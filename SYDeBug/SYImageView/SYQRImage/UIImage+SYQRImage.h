//
//  UIImage+SYQRImage.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/1/12.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SYQRImage)

/**
 生成二维码
 
 @param content 字符串
 @param width 正方形，只需要传长或宽
 @param padding 内边距
 @param red 0~255
 @param green 0~255
 @param blue 0~255
 @return Qrcode Image
 */
+ (UIImage *)qrCodeImageWithContent:(NSString *)content
                              width:(CGFloat)width
                            padding:(CGFloat)padding
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(CGFloat)blue;

@end

NS_ASSUME_NONNULL_END
