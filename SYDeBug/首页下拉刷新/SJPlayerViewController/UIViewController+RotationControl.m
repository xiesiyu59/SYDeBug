//
//  UIViewController+RotationControl.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/6/21.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "UIViewController+RotationControl.h"

@implementation UIViewController (RotationControl)

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
