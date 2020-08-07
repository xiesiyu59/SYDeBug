//
//  UIView+SYView.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/7/17.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "UIView+SYView.h"

@implementation UIView (SYView)

- (void)setX:(CGFloat)x{
    CGFloat y = self.frame.origin.y;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(x, y, width, height);
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGFloat x = self.frame.origin.x;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(x, y, width, height);
}

- (CGFloat)y{
    return self.frame.origin.y;
}
- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


#pragma mark - <Cornerdious>

- (void)setLXCornerdious:(CGFloat)cornerdious{
    
    self.layer.cornerRadius = cornerdious;
    self.layer.masksToBounds = YES;
}

- (void)setLXBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setSYDottedLineStroke:(UIColor *)strokeColor fillColor:(UIColor *)fillColor{
    
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = strokeColor.CGColor;
    //填充的颜色
    border.fillColor = fillColor.CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5];
    //设置路径
    border.path = path.CGPath;
    
    border.frame = self.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    
    //设置线条的样式
//    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = YES;
    
    [self.layer addSublayer:border];
}


+ (void)setSYCornerRadiusBezierPath:(UIView *)view RoundingCorners:(UIRectCorner)corners radii:(CGSize)radii {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

#pragma mark - <Shadow>
+ (UIView *)defaultShadow{
    
    UIView *view =[UIView  new];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.05f;
    view.layer.shadowRadius = 4.f;
    view.layer.shadowOffset = CGSizeMake(0,0);
    return view;
}

@end
