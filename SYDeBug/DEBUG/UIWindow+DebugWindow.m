//
//  UIWindow+DebugWindow.m
//  MultiplexingFunction
//
//  Created by xiesiyu on 2018/2/9.
//  Copyright © 2018年 xiesiyu. All rights reserved.
//

#import "UIWindow+DebugWindow.h"
#import <FLEX.h>

@implementation UIWindow (DebugWindow)

#if DEBUG
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    [super motionBegan:motion withEvent:event];
    if (motion == UIEventSubtypeMotionShake) {
        
        [[FLEXManager sharedManager] setNetworkDebuggingEnabled:YES];
        [[FLEXManager sharedManager] showExplorer];
    }
    
}
#endif

@end
