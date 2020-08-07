//
//  LabelNumberAnimation.h
//  消汇邦
//
//  Created by xiesiyu on 2018/5/10.
//  Copyright © 2018年 深圳消汇邦成都分公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberAnimation : NSObject

//金额动画

/**
 金额数字交互动画

 @param numLabel UILabl
 @param start 开始字符
 @param end 结束字符&&结束显示字符
 @param type 0是.00  1是整数
 */
+ (void)labelNumAnimationLabel:(UILabel *)numLabel start:(NSString *)start end:(NSString *)end type:(NSInteger)type;

@end
