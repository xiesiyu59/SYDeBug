//
//  UIImage+SYGradualImage.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/1/12.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GradientType) {
    GradientFromTopToBottom = 1,            //从上到下
    GradientFromLeftToRight,                //从做到右
    GradientFromLeftTopToRightBottom,       //从上到下
    GradientFromLeftBottomToRightTop        //从上到下
};

@interface UIImage (SYGradualImage)

/**
 *  根据给定的颜色，生成渐变色的图片
 *  @param imageSize        要生成的图片的大小
 *  @param colorArr         渐变颜色的数组
 *  @param percents          渐变颜色的占比数组
 *  @param gradientType     渐变色的类型
 */
+ (UIImage *)createImageWithSize:(CGSize)imageSize
                  gradientColors:(NSArray *)colorArr
                      percentage:(NSArray *)percents
                    gradientType:(GradientType)gradientType;


/**
 转化成服务要求的base64字符串

 @param compressionQuality 压缩比率0～1
 @return 字符串
 */
- (NSString *)convertToBase64StringWithCompressionQuality:(CGFloat)compressionQuality;

@end

NS_ASSUME_NONNULL_END
