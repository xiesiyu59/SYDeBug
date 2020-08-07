//
//  SYColorLabel.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/8/7.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SYColorLabel.h"

@implementation SYColorLabel

- (void)drawRect:(CGRect)rect {
    // 1.绘制文字
    [super drawRect:rect];
    
    rect.size.width *= self.colorRatio;
    // 2.设置颜色
    [self.blendColor set];
    
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
}

- (void)setColorRatio:(CGFloat)colorRatio {
    _colorRatio = colorRatio;
    
    [self setNeedsDisplay];
}

@end
