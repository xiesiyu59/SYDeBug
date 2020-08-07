//
//  UIView+SYView.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/7/17.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SYView)

#pragma mark - <Frame>

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 * The view controller whose view contains this view.
 */
- (UIViewController*)viewController;


#pragma mark - <Cornerdious>
/**
 设置全部圆角

 @param cornerdious 圆角弧度
 */
- (void)setLXCornerdious:(CGFloat)cornerdious;

/**
 设置border 以及color

 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 */
- (void)setLXBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 设置边框线

 @param strokeColor 边框线颜色
 @param fillColor 填充色
 */
- (void)setSYDottedLineStroke:(UIColor *)strokeColor fillColor:(UIColor *)fillColor;


/// 设置部分圆角
/// @param view 控件
/// @param corners 圆角部分
/// @param radii 大小
+ (void)setSYCornerRadiusBezierPath:(UIView *)view RoundingCorners:(UIRectCorner)corners radii:(CGSize)radii;

#pragma mark - <Shadow>

+ (UIView *)defaultShadow;

@end

NS_ASSUME_NONNULL_END
