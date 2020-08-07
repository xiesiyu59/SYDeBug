//
//  NSString+AmountCalculation.h
//  MultiplexingFunction
//
//  Created by xiesiyu on 2019/4/17.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, CalculationType){
    
    CalculationTypeAdd = 0,
    CalculationTypeSubtract,
    CalculationTypeMultiply,
    CalculationTypeDivide
};

@interface NSString (AmountCalculation)


/// 计算金额
/// @param type 计算类型
/// @param ln 参数
/// @param rn 被参数
+ (NSString *)amountCalculationType:(CalculationType)type
                                 ln:(NSString *)ln
                                 rn:(NSString *)rn;

@end

NS_ASSUME_NONNULL_END
