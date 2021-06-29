//
//  UIImage+image.h
//  Footstone
//
//  Created by xiesiyu on 2020/8/17.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SYImage)
+(UIImage *)srentchImageWithIcon:(NSString *)icon;
+(UIImage *)srentchImageWithIcon:(NSString *)icon width:(float) with heigh:(float)heigh;
-(UIImage *)originImage:(UIImage *)image   scaleToSize:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;
//指定宽度按比例缩放
+(UIImage *) imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
//返回一个图片
+ (UIImage *)imageDataUrl:(NSString *)urlString;
/**
 Resize

 @param newSize 新大小
 @return 图片
 */
- (UIImage *)scaledToSize:(CGSize)newSize;


@end
