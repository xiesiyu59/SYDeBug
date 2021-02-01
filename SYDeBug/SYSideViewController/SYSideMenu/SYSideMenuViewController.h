//
//  SYSideMenuViewController.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/2/1.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYSideMenuViewController : UIViewController

@property (nonatomic, strong) UIViewController *centerViewController;
@property (nonatomic, strong) UIViewController *leftSideViewController;
@property (nonatomic, assign) CGFloat leftVisibleOffset;

@property (nonatomic, assign) BOOL isRightShow;
@property (nonatomic, assign) BOOL isLeftShow;
@property (nonatomic, assign) BOOL showAble;
- (SYSideMenuViewController *)initWithContentViewController:(UIViewController *)contentViewController leftSideViewController:(UIViewController *)leftSideViewController;

- (void)showLeftSideMenu;
- (void)hiddenAll;

@end

NS_ASSUME_NONNULL_END
