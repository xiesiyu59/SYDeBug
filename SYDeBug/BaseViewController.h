//
//  BaseViewController.h
//  SYDeBug
//
//  Created by xiesiyu on 2019/10/29.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface BaseViewController : UIViewController

@property (nonatomic, strong)NSDictionary *routeParam;



/// 控制器返回
- (void)controllerViewBack;

/// 需要删除先前的页面数
@property (nonatomic, assign)NSInteger        deleteViewCount;

/// 若要禁止侧滑返回，必须重写方法
- (BOOL)sy_interactivePopDisabled;

/// 导航栏隐藏显示
- (BOOL)sy_preferredNavigationBarHidden;

/// 屏幕横屏
- (void)sy_screenFlip;

@end

NS_ASSUME_NONNULL_END
