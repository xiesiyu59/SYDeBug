//
//  SYDevice.h
//  UrumqiMetro
//
//  Created by xiesiyu on 2019/5/13.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYDevice : NSObject

+ (BOOL)isPhoneX;

//系统提示框
+ (void)showAlertViewTitle:(NSString *)title;
+ (void)showAlertViewTitle:(NSString *)title completed:(void (^)(void))completed;

@end

NS_ASSUME_NONNULL_END
