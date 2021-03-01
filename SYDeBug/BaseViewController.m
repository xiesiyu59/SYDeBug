//
//  BaseViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2019/10/29.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "BaseViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "AppDelegate.h"


@interface BaseViewController ()

@property (nonatomic, assign)BOOL fullScreen;

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
    NSLog(@"已经消失");
}



- (void)setNewOrientation:(BOOL)fullscreen{
    if (fullscreen) {
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }else{
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }
}

//横竖屏切换按钮方法
-(void)sy_screenFlip{
    //记着#import "AppDelegate.h"
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (self.fullScreen) {//横屏情况下，点击此按钮变为竖屏
        appDelegate.allowRotation = NO;//设置竖屏
        [self setNewOrientation:NO];//调用转屏代码
        self.fullScreen = NO;
        self.navigationController.navigationBar.hidden = NO;//navbar消失
    }else{//竖屏情况下，点击此按钮变为横屏
        appDelegate.allowRotation = YES;////设置横屏
        [self setNewOrientation:YES];////调用转屏代码
        self.navigationController.navigationBar.hidden = YES;//navbar出现
        self.fullScreen = YES;
    }
}



- (void)dealloc{
    
    NSLog(@"%@  dealloc",NSStringFromClass([self class]));
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
