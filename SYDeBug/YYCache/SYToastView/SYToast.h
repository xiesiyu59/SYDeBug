//
//  SYToast.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/18.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYToast : UIView

+ (instancetype)sharedInstance;

+ (void)showWithMessage:(NSString *)message;

+ (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
