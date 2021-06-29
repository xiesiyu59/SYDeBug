//
//  UINavigationController+RotationControl.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/6/21.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "UINavigationController+RotationControl.h"

@implementation UINavigationController (RotationControl)

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (nullable UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (nullable UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

@end
