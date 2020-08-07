//
//  PrivacyPermissionManager.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/7/2.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "PrivacyPermissionManager.h"
#import "SYDevice.h"

static PrivacyPermissionManager *instance = nil;

@implementation PrivacyPermissionManager

#pragma mark - 单利 - 创建管理对象
+ (instancetype)manager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PrivacyPermissionManager alloc] init];
    });
    return instance;
}

- (void)openLocationServiceWithBlock:(void(^)(BOOL open))returnBlock {
    
    BOOL isOPen = NO;
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        isOPen = YES;
        if (returnBlock) {
            returnBlock(isOPen);
        }
    }
    if (!isOPen) {
        //未开启
        [SYDevice showAlertViewTitle:@"无法定位，请打开定位权限" completed:^{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        }];
    }
    
}






@end
