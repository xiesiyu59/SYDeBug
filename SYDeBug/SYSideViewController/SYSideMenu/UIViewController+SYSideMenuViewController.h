//
//  UIViewController+SYSideMenuViewController.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/2/1.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SYSideMenuViewController;

@interface UIViewController (SYSideMenuViewController)

@property (nonatomic, strong, readonly) SYSideMenuViewController *sideMenuViewController;

@end

NS_ASSUME_NONNULL_END
