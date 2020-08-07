//
//  SYVideoPlayerProgressView.m
//  PetStore
//
//  Created by xiesiyu on 2020/6/3.
//  Copyright © 2020 Petstore. All rights reserved.
//

#import "SYVideoPlayerProgressView.h"

@implementation SYVideoPlayerProgressView

- (void)layoutThatFits:(CGRect)constrainedRect
nearestViewControllerInViewTree:(UIViewController *_Nullable)nearestViewController
  interfaceOrientation:(JPVideoPlayViewInterfaceOrientation)interfaceOrientation {
    [super layoutThatFits:constrainedRect
nearestViewControllerInViewTree:nearestViewController
     interfaceOrientation:interfaceOrientation];
    
    self.trackProgressView.hidden = YES;
    self.cachedProgressView.hidden = YES;
    self.elapsedProgressView.hidden = YES;
    
    self.trackProgressView.frame = CGRectMake(0,
                                              constrainedRect.size.height - JPVideoPlayerProgressViewElementHeight - nearestViewController.tabBarController.tabBar.bounds.size.height,
                                              constrainedRect.size.width,
                                              JPVideoPlayerProgressViewElementHeight);
    self.cachedProgressView.frame = self.trackProgressView.bounds;
    self.elapsedProgressView.frame = self.trackProgressView.frame;
}


@end
