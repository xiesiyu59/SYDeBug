//
//  UIViewController+SYSideMenuViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/2/1.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "UIViewController+SYSideMenuViewController.h"
#import "SYSideMenuViewController.h"

@implementation UIViewController (SYSideMenuViewController)

- (SYSideMenuViewController *)sideMenuViewController {
    
    UIViewController *superVC = self.parentViewController;
    while (superVC) {
        if ([superVC isKindOfClass:[SYSideMenuViewController class]]) {
            return (SYSideMenuViewController *)superVC;
        } else if (superVC.parentViewController && superVC.parentViewController != superVC) {
            superVC = superVC.parentViewController;
        } else {
            superVC = nil;
        }
    }
    return nil;
}

@end
