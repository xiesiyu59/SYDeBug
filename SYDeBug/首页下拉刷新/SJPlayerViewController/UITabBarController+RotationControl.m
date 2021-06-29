//
//  UITabBarController+RotationControl.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/6/21.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "UITabBarController+RotationControl.h"

@implementation UITabBarController (RotationControl)

- (UIViewController *)sj_topViewController {
    if ( self.selectedIndex == NSNotFound )
        return self.viewControllers.firstObject;
    return self.selectedViewController;
}

- (BOOL)shouldAutorotate {
    return [[self sj_topViewController] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [[self sj_topViewController] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self sj_topViewController] preferredInterfaceOrientationForPresentation];
}

@end
