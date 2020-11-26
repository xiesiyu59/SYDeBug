//
//  LocationNoticeViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/11/26.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "LocationNoticeViewController.h"
#import <UserNotifications/UserNotifications.h>


@interface LocationNoticeViewController ()

@end

@implementation LocationNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNotification];
}


- (void)addNotification {
    // 创建一个通知内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.badge = @1;
    content.title = @"title";
    content.subtitle = @"subtitle";
    content.body = @"body";
    content.sound = [UNNotificationSound defaultSound];
    content.categoryIdentifier = @"category";
    
    
    // 通知触发器
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:false];
    // 通知请求
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"noti" content:content trigger:trigger];
    //添加通知
    [UNUserNotificationCenter.currentNotificationCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
        NSLog(@"error:%@",error);
    }];
    // 添加通知的一些操作
    UNNotificationAction *openAction = [UNNotificationAction actionWithIdentifier:@"open" title:@"打开" options:UNNotificationActionOptionForeground];
    UNNotificationAction *closeAction = [UNNotificationAction actionWithIdentifier:@"close" title:@"关闭" options:UNNotificationActionOptionDestructive];
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"category" actions:@[openAction, closeAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        
    NSSet *sets = [NSSet setWithObject:category];
    [UNUserNotificationCenter.currentNotificationCenter setNotificationCategories:sets];
}

- (void)removeNotifiation {
    // 移除 待处理的通知
    [UNUserNotificationCenter.currentNotificationCenter removePendingNotificationRequestsWithIdentifiers:@[@"noti"]];
    // 移除 已经处理的通知
    [UNUserNotificationCenter.currentNotificationCenter removeDeliveredNotificationsWithIdentifiers:@[@"noti"]];
    
    // 移除所有的通知
    [UNUserNotificationCenter.currentNotificationCenter removeAllDeliveredNotifications];
    [UNUserNotificationCenter.currentNotificationCenter removeAllPendingNotificationRequests];
}


- (void)dealloc{
    NSLog(@"dealloc");
//    [self removeNotifiation];
}


@end
