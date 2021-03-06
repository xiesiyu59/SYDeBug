//
//  AppDelegate.m
//  SYDeBug
//
//  Created by xiesiyu on 2019/10/29.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "ViewController.h"
#import <Aspects.h>
#import "YYCacheViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "InfoLeftViewController.h"
#import "SYSideMenuHeader.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    BaseNavigationController *navc = [[BaseNavigationController alloc] initWithRootViewController:[ViewController new]];

//    SYSideMenuViewController *sideMenuVc = [[SYSideMenuViewController alloc] initWithContentViewController:navc leftSideViewController:[[InfoLeftViewController alloc] init]];
    
    self.window.rootViewController = navc;
    [self.window makeKeyAndVisible];
    //路由配置
    [self routeConfig];
    //网路检测配置
    [self reachabilityManagerConfig];
    //注册通知
    [self registerNotification];
    //获取系统语言
    [self getCurrentLanguage];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
    
    return YES;
}

- (void)getCurrentLanguage{
    
    NSString *pfLanguageCode = [NSLocale preferredLanguages][0];
    NSLog(@"%@", pfLanguageCode);
}


// - 事件处理
/** 程序进入后台的通知的事件监听 */
-(void)appEnterBackground{
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
}
/** 程序被kill */
-(void)applicationWillTerminate{
    //  - 监听到 app 被kill时候的回调....
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"kill");
    
}

- (void)reachabilityManagerConfig{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


- (void)routeConfig{
    
    NSError *error;
    [BaseViewController aspect_hookSelector:@selector(setRouteParam:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        BaseViewController *vc = aspectInfo.instance;
        [vc.routeParam enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [vc setValue:obj forKey:key];
        }];
    } error:&error];
    if (error) {
        
    }
    
}

- (void)registerNotification {
    
    UNAuthorizationOptions options = UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge;
    UNUserNotificationCenter.currentNotificationCenter.delegate = self;
    [UNUserNotificationCenter.currentNotificationCenter requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 允许授权
        } else {
            // 不允许授权
        }
    }];
    
    // 获取用户对通知的设置
    // 通过settings.authorizationStatus 来处理用户没有打开通知授权的情况
    [UNUserNotificationCenter.currentNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        NSLog(@"%@",settings);
    }];
}

// 在前台时 收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
    }
    NSLog(@"%@",userInfo);
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge);
}


// 点击通知，从后台进入前台
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSString *identifier =  response.actionIdentifier;
    if ([identifier isEqualToString:@"open"]) {
        NSLog(@"打开操作");
    } else if ([identifier isEqualToString:@"close"]) {
        NSLog(@"关闭操作");
    }
    completionHandler();
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    //即将进入前台
    NSLog(@"即将进入前台");
    
//    程序将要失去Active状态时调用，比如按下Home键或有电话信息进来。之后程序将进入后台状态。对应的applicationWillEnterForeground这个方法用来
//    a、暂停正在执行的任务；
//    b、禁止计时器；
//    c、减少OpenGL ES帧率；
//    d、若为游戏应暂停游戏；
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //已经进入后台
    NSLog(@"已经进入后台");
    
//    程序已经进入后台时调用，对应applicationDidBecomeActive（已经变成前台），这个方法用来
//    a、释放共享资源；
//    b、保存用户数据（写到硬盘）；
//    c、作废计时器；
//    d、保存足够的程序状态以便下次恢复；
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //即将进入前台
    NSLog(@"即将进入前台");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //已经变成前台
    NSLog(@"已经变成前台");
    
    //获取或设置剪切板中的字符串数据@property(nullable,nonatomic,copy)NSString*string;
    //获取或设置剪切板中的字符串数组@property(nullable,nonatomic,copy)NSArray *strings;
    //获取或设置剪切板中的URL数据@property(nullable,nonatomic,copy)NSURL*URL;
    //获取或设置剪切板中的URL数组@property(nullable,nonatomic,copy)NSArray *URLs;
    //获取或s何止剪切板中的图片数据@property(nullable,nonatomic,copy)UIImage*image;
    //获取或设置剪切板中的图片数组@property(nullable,nonatomic,copy)NSArray *images;
    //获取或设置剪切板中的颜色数据@property(nullable,nonatomic,copy)UIColor*color;
    //获取或设置剪切板中的颜色数组@property(nullable,nonatomic,copy)NSArray *colors;

//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    NSLog(@"%@",pasteboard.string);
    
//    程序已经变为Active（前台）时调用。对应applicationDidEnterBackground（已经进入后台）。
//    1.若程序之前在后台，在此方法内刷新用户界面。
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if (_allowRotation == YES) {
        return UIInterfaceOrientationMaskLandscapeRight;
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}

@end
