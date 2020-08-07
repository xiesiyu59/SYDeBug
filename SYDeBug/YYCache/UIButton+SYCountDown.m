//
//  UIButton+SYCountDown.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/12.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "UIButton+SYCountDown.h"
#import <objc/runtime.h>

static NSString * timeKey = @"timeKey"; //name的key

@implementation UIButton (SYCountDown)

/**
 setter方法
 */

- (void)setSyName:(NSString *)syName{
    
    objc_setAssociatedObject(self, &timeKey, syName, OBJC_ASSOCIATION_COPY);
}

/**
 getter方法
 */

- (NSString *)syName{
    return objc_getAssociatedObject(self, &timeKey);
}

@end
