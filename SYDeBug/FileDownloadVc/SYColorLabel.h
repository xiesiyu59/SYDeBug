//
//  SYColorLabel.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/8/7.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYColorLabel : UILabel

///  变色比例  0~1
@property (nonatomic, assign) CGFloat colorRatio;
///  混合颜色
@property (nonatomic, strong) UIColor *blendColor;

@end

NS_ASSUME_NONNULL_END
