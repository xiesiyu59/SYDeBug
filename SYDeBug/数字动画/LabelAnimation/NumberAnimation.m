//
//  NumberAnimation.m
//
//  Created by xiesiyu on 2018/5/10.
//

#import "NumberAnimation.h"
#import <PPCounter.h>

@implementation NumberAnimation

//金额动画
+ (void)numAnimationControl:(id)control start:(NSString *)start end:(NSString *)end type:(NSInteger)type {
    
    CGFloat origin = [start floatValue];
    CGFloat remain = [end floatValue];
    if (origin <= 0) {
        origin = 0;
    }
    UILabel *tempLabel;
    UIButton *tempButton;
    
    if ([control isKindOfClass:[UILabel class]]) {
        tempLabel = control;
        [tempLabel pp_fromNumber:origin toNumber:remain duration:1 animationOptions:PPCounterAnimationOptionCurveEaseOut format:^NSString *(CGFloat number) {
            
            if (type == 0) {
                return [NSString stringWithFormat:@"%.2f",number];
            }else {
                return [NSString stringWithFormat:@"%.f",number];
            }
            
        } completion:^(CGFloat endNumber) {
            
            tempLabel.text = end;
        }];
    }else if ([control isKindOfClass:[UIButton class]]){
        tempButton = control;
        [tempButton pp_fromNumber:origin toNumber:remain duration:1 animationOptions:PPCounterAnimationOptionCurveEaseOut format:^NSString *(CGFloat number) {
            
            if (type == 0) {
                return [NSString stringWithFormat:@"%.2f",number];
            }else {
                return [NSString stringWithFormat:@"%.f",number];
            }
            
        } completion:^(CGFloat endNumber) {
            
            [tempButton setTitle:end forState:UIControlStateNormal];
        }];
    }
    
    
}

@end
