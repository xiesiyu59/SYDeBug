//
//  NumberAnimation.h
//
//  Created by xiesiyu on 2018/5/10.
//

#import <Foundation/Foundation.h>

@interface NumberAnimation : NSObject

/**
 金额数字交互动画

 @param control UILabl/UIButton
 @param start 开始字符
 @param end 结束字符&&结束显示字符
 @param type 0是.00  1是整数
 */
+ (void)numAnimationControl:(id)control start:(NSString *)start end:(NSString *)end type:(NSInteger)type;

@end
