//
//  BaseNavigationController.m
//  hotlover
//
//  Created by silencetom on 2019/5/15.
//  Copyright © 2019 silencetom. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBarItem.selectedImage = [self.tabBarItem.selectedImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    self.tabBarItem.image = [self.tabBarItem.image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.shadowImage = [UIImage new];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
    self.navigationBar.tintColor = [UIColor blackColor];
    self.navigationBar.translucent = NO;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    UIViewController *vc = viewControllers.lastObject;
    vc.hidesBottomBarWhenPushed = YES;
    [super setViewControllers:viewControllers animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return [[self visibleViewController] preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden {
    return [[self visibleViewController] prefersStatusBarHidden];
}

@end
