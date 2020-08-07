//
//  NSString+AmountCalculation.m
//  MultiplexingFunction
//
//  Created by xiesiyu on 2019/4/17.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "NSString+AmountCalculation.h"

@implementation NSString (AmountCalculation)


+ (NSString *)amountCalculationType:(CalculationType)type ln:(NSString *)ln rn:(NSString *)rn {
    
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
    decimalNumberHandlerWithRoundingMode:NSRoundUp
    scale:2
    raiseOnExactness:NO
    raiseOnOverflow:NO
    raiseOnUnderflow:NO
    raiseOnDivideByZero:YES];
    
    NSDecimalNumber *decimalNumberLeft = [NSDecimalNumber decimalNumberWithString:ln];
    NSDecimalNumber *decimalNumberRight = [NSDecimalNumber decimalNumberWithString:rn];
    NSDecimalNumber *subTotal;
    
    switch (type) {
        case CalculationTypeAdd:{
           subTotal = [decimalNumberLeft decimalNumberByAdding:decimalNumberRight];
        }break;
        case CalculationTypeSubtract:{
            subTotal = [decimalNumberLeft decimalNumberBySubtracting:decimalNumberRight];
        }break;
        case CalculationTypeMultiply:{
            subTotal = [decimalNumberLeft decimalNumberByMultiplyingBy:decimalNumberRight];
        }break;
        case CalculationTypeDivide:{
            subTotal = [decimalNumberLeft decimalNumberByDividingBy:decimalNumberRight];
        }break;
        default:break;
    }
    NSDecimalNumber *returnTotal = [subTotal decimalNumberByRoundingAccordingToBehavior:roundUp];
    return [NSString stringWithFormat:@"%@",returnTotal];
}


@end
