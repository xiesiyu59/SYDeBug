//
//  SYPhotoModel.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/6/29.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SYPhotoBrowserType) {
    SYPhotoBrowserTypeImage = 0, //图片
    SYPhotoBrowserTypeUrl,      //链接图片
};


@interface SYPhotoModel : NSObject

/** 原图链接 */
@property (nonatomic, strong) NSURL *originImageUrl;

/** 缩略链接 */
@property (nonatomic, strong) NSURL *thumbImageUrl;

/** 缩略图片 */
@property (nonatomic, strong) UIImage  *thumbImage;

/** 原图图片 */
@property (nonatomic, strong) UIImage  *originImage;

/** 数据是否更新 */
@property (nonatomic, assign) BOOL modelUpdate;

/** 是否是当前图片 */
@property (nonatomic, assign) BOOL isCurrentItem;

/** 是否有二维码 */
@property (nonatomic, assign) BOOL hasQrcode;

/** 二维码 */
@property (nonatomic, strong) NSString *qrCode;

@property (nonatomic, assign) SYPhotoBrowserType type;

//图片
- (instancetype)initWithImage:(UIImage *)image;

//图片链接
- (instancetype)initWithImageUrl:(NSString *)imageUrl;

@end

NS_ASSUME_NONNULL_END
