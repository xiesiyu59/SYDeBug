//
//  SYPhotoBrowserVc.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/6/29.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPhotoModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface SYPhotoBrowserVc : UIViewController

/** 被点击的图片 */
@property (nonatomic, strong) UIImageView *imageView;

/** 被点击的图片在图片数组的位置 */
@property (nonatomic, assign) NSUInteger currentIndex;

/** 当前Window的截图 */
@property (nonatomic, strong) UIImage     *screenImage;

/** 图片数组 */
@property (nonatomic, strong) NSArray<NSString *> *imageUrlArr;

/** 消息数组 */
@property (nonatomic, strong) NSArray<UIImage *> *imageArr;


/** 当前状态栏的风格 */
@property (nonatomic, assign) UIStatusBarStyle fromViewStatusBarStyle;

/** 类型分为两种，需对相应数据源赋值 */
@property (nonatomic, assign) SYPhotoBrowserType type;

/**
 构造方法

 @param dataSource 数据源，可以是消息数组，图片链接数组，用户Uid数组（只包含一个uid的数组）
 @param currentIndex 当前索引，如果索引数超过数据源个数，索引为最后一个
 @param imageView 图片
 @param type 类型
 @param currentVc 当前控制器
 */

+ (void)showWithDataSource:(NSArray *)dataSource
              currentIndex:(NSInteger)currentIndex
                 imageView:(UIImageView *)imageView
                      type:(SYPhotoBrowserType)type
                 currentVc:(UIViewController *)currentVc;

@end

NS_ASSUME_NONNULL_END
