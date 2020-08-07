//
//  BaseViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2019/10/29.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "BaseViewController.h"
#import <FDFullscreenPopGesture-umbrella.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark -
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"设置路由参数错误,不存在Key: %@",key);
}

- (void)setNilValueForKey:(NSString *)key{
    NSLog(@"设置路由参数错误,Key为nil: %@",key);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"箭头返回_黑"] style:UIBarButtonItemStylePlain target:self action:@selector(controllerViewBack)];
    self.navigationItem.leftBarButtonItem = item;
    
    if (@available(iOS 11.0, *)) {
        
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.fd_prefersNavigationBarHidden = [self sy_preferredNavigationBarHidden];
    self.fd_interactivePopDisabled = [self sy_interactivePopDisabled];
    //适配iOS11关闭位置偏移
    if (@available(iOS 11.0, *)) {
        
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self appEnterBackground];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
    NSLog(@"将要显示");
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    NSLog(@"已经显示");
    
    if (self.deleteViewCount) {
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        NSInteger removeCount = self.deleteViewCount;
        if (array.count >= removeCount + 1) {
            [array removeObjectsInRange:NSMakeRange(array.count - (removeCount + 1), removeCount)];
            self.navigationController.viewControllers = array;
        }
        self.deleteViewCount = 0;//保证只允许一次
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    NSLog(@"将要消失");
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"已经消失");
}



// - 事件处理
/** 程序进入后台的通知的事件监听 */
-(void)appEnterBackground{
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
}
/** 程序被kill */
-(void)applicationWillTerminate{
    //  - 监听到 app 被kill时候的回调....
    NSLog(@"dealloc%@",[UIViewController getCurrentVC]);
}



- (BOOL)sy_interactivePopDisabled{
    
    return NO;
}

- (BOOL)sy_preferredNavigationBarHidden {
    
    return NO;
}


- (void)controllerViewBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
