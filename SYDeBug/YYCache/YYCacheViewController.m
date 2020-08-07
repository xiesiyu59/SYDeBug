//
//  YYCacheViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/5/22.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "YYCacheViewController.h"
#import "LocalDataTool.h"
#import "UIButton+SYCountDown.h"
#import "KeyChainTool.h"
#import "SYToast.h"
#import "SYProgressHUD.h"
#import "SYDevice.h"
#import "PrivacyPermissionManager.h"
#import <CoreLocation/CoreLocation.h>
#import "NSDate+SYExtensions.h"
#import "NSString+XSYTimeDHMS.h"
#import "UIView+SYView.h"
#import "SYPromptOptionView.h"

#define gcdButton @"gcdButton"

@interface YYCacheViewController () <CLLocationManagerDelegate> {
    
}

@property (nonatomic, strong)dispatch_source_t buttonTimer;
 

@end

@implementation YYCacheViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"存储方式";
    [self initWithInitialization];
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"存" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.backgroundColor = [UIColor orangeColor];
    leftButton.tag = 0;
    [leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScreenTopIsX);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"读取" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor orangeColor];
    rightButton.tag = 1;
    [rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScreenTopIsX);
        make.left.equalTo(leftButton.mas_right);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    UIButton *crightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [crightButton setTitle:@"删除" forState:UIControlStateNormal];
    [crightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    crightButton.backgroundColor = [UIColor orangeColor];
    crightButton.tag = 2;
    [crightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:crightButton];
    [crightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScreenTopIsX);
         make.left.equalTo(rightButton.mas_right);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    UIButton *countButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [countButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [countButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    countButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:countButton];
    if ([LocalDataTool readDataDefaultsWithForKey:gcdButton] != nil) {
        [self openCountDown:countButton];
    }
    [countButton addTarget:self action:@selector(openCountDown:) forControlEvents:UIControlEventTouchUpInside];
    [countButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftButton.mas_bottom).offset(10);
        make.left.equalTo(leftButton.mas_left);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    UIButton *toastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [toastButton setTitle:@"提示框" forState:UIControlStateNormal];
    [toastButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    toastButton.backgroundColor = [UIColor yellowColor];
    toastButton.tag = 3;
    [self.view addSubview:toastButton];
    [toastButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [toastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countButton.mas_top);
        make.left.equalTo(countButton.mas_right);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    
    UIButton *mbhudButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mbhudButton setTitle:@"菊花框" forState:UIControlStateNormal];
    [mbhudButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    mbhudButton.backgroundColor = [UIColor yellowColor];
    mbhudButton.tag = 4;
    [self.view addSubview:mbhudButton];
    [mbhudButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [mbhudButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toastButton.mas_top);
        make.left.equalTo(toastButton.mas_right);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
//    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
//    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
//    BOOL res3 = [(id)[LocalDataTool class] isKindOfClass:[LocalDataTool class]];
//    BOOL res4 = [(id)[LocalDataTool class] isMemberOfClass:[LocalDataTool class]];
//
//    NSLog(@"%lu--%lu--%lu--%lu",res1,res2,res3,res4);
    
    //B8448DE7-7FC1-41F9-A975-D73F9101CC65
    NSLog(@"%@",[KeyChainTool UUID]);
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    
    UIButton *jurisdictionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [jurisdictionButton setTitle:@"权限判断" forState:UIControlStateNormal];
    [jurisdictionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jurisdictionButton.backgroundColor = [UIColor yellowColor];
    jurisdictionButton.tag = 5;
    
    
    
    [self.view addSubview:jurisdictionButton];
    [jurisdictionButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [jurisdictionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countButton.mas_bottom).offset(10);
        make.left.equalTo(countButton);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    [self.view layoutIfNeeded];
    [UIView setSYCornerRadiusBezierPath:jurisdictionButton RoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight radii:CGSizeMake(5, 5)];
    
    
    UIButton *tipsBoxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tipsBoxButton setTitle:@"提示选项框" forState:UIControlStateNormal];
    [tipsBoxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tipsBoxButton.backgroundColor = [UIColor yellowColor];
    tipsBoxButton.tag = 6;
    [self.view addSubview:tipsBoxButton];
    [tipsBoxButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tipsBoxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toastButton.mas_bottom).offset(10);
        make.left.equalTo(toastButton.mas_left);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    
    
    NSLog(@"%@",[self compareCurrentTime:@"2020-01-07 14:20:00"]);
    NSLog(@"%@",[NSString stringTimeConversionTimestamp:@"2020-07-14" dateformater:@"yyyy-MM-dd"]);
    NSLog(@"%@",[NSString timestampConversionStringTime:1594656000 dateformater:@"yyyy.MM.dd HH.mm.ss"]);
    
    
}



- (void)buttonClick:(UIButton *)sender{

    if (sender.tag == 0) {
        NSLog(@"存");
//        [LocalDataTool writeDataCacheValue:@"本地封装" withForKey:@"testNameId"];
        NSDictionary *dict = @{@"id":@"0001",
                               @"user":@"王小明",
                               @"sex":@"男",};
        [LocalDataTool writeDataPlistValue:dict withForKey:@"userInfo"];
//        [LocalDataTool writeDataDefaultsValue:dict withForKey:@"userInfo"];
    }else if (sender.tag == 1){
//        NSLog(@"取%@",(NSString *)[LocalDataTool readDataCacheWithForKey:@"testNameId"]);
        NSLog(@"取%@",(NSDictionary *)[LocalDataTool readDataPlistWithForKey:@"userInfo"]);
//        NSLog(@"取%@", [LocalDataTool readDataDefaultsWithForKey:@"userInfo"]);
    }else if (sender.tag == 2){
        NSLog(@"删除");
//        [LocalDataTool removeDataCacheWhiteForKey:@"testNameId"];
        [LocalDataTool removeDataPlist];
//        [LocalDataTool removeDataDefaultsWhiteForKey:@"userInfo"];
    }else if (sender.tag == 3){
        
        [SYToast showWithMessage:@"我就是着急了"];
    }else if (sender.tag == 4){
        
        [SYProgressHUD messageSuccess:@"成功了"];
//        [SYProgressHUD progressMessage:@""];
//        [SYProgressHUD progressView:self.view Message:@"下载中..."];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SYProgressHUD hideHUD];
//            [SYProgressHUD hideHUDForView:self.view];
//        });
        
//        [SYDevice showAlertViewTitle:@"牛逼啊"];
//        [SYDevice showAlertViewTitle:@"还是牛逼啊" completed:^{
//
//        }];
        
        switch ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
            case AFNetworkReachabilityStatusUnknown:{
                //未知网络
                NSLog(@"未知网络");
            }break;
            case AFNetworkReachabilityStatusNotReachable:{
                //无法联网
                NSLog(@"无法联网");
            }break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                //手机自带网络
                NSLog(@"当前使用的是2g/3g/4g网络");
            }break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                //WIFI
                NSLog(@"当前在WIFI网络下");
            }break;
        }
        
    }else if (sender.tag == 5){
        
        [[PrivacyPermissionManager manager] openLocationServiceWithBlock:^(BOOL open) {
            if (open) {
                /** 由于IOS8中定位的授权机制改变 需要进行手动授权
                     * 获取授权认证，两个方法：
                     * [self.locationManager requestWhenInUseAuthorization];
                     * [self.locationManager requestAlwaysAuthorization];
                     */
                self.locationManager.delegate = self;
                if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                    NSLog(@"requestAlwaysAuthorization");
                    [self.locationManager requestAlwaysAuthorization];
                }
                
                //开始定位，不断调用其代理方法
                [self.locationManager startUpdatingLocation];
                NSLog(@"start gps");
            }
        }];
    }else if(sender.tag == 6){
        
        [SYPromptOptionView showWithContentStr:@"提示选项框" successTitle:@"确定" successBlock:^{
            NSLog(@"成功");
        }cancelTitle:@"" cancelBlock:nil];
    }
    
}


-(void)openCountDown:(UIButton *)sender{
    
    __block NSInteger time = 0;
    NSString *locaTime = [LocalDataTool readDataDefaultsWithForKey:gcdButton];
    if (!locaTime) {
         time = 59; //倒计时时间
        [LocalDataTool writeDataDefaultsValue:@(time) withForKey:gcdButton];
    }else{
        time = [locaTime integerValue];
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.buttonTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.buttonTimer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(self.buttonTimer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            [LocalDataTool removeDataDefaultsWhiteForKey:gcdButton];
            dispatch_source_cancel(self.buttonTimer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [sender setTitle:@"重新发送" forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            [LocalDataTool writeDataDefaultsValue:@(seconds) withForKey:gcdButton];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [sender setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(self.buttonTimer);

}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    // 2.停止定位
    [manager stopUpdatingLocation];
    manager.delegate = nil;
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}



-(NSString *)compareCurrentTime:(NSString *)str {
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    long temp = 0;
    NSString *result;
    if (timeInterval/60 < 1) {
        
        result = [NSString stringWithFormat:@"刚刚"];
        
    }else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
        
    }else if((temp = temp/60) <24){
        
        result = [NSString stringWithFormat:@"%ld小时前",temp];
        
    }else if((temp = temp/24) <30){
        
        result = [NSString stringWithFormat:@"%ld天前",temp];
        
    }else if((temp = temp/30) <12){
        
        result = [NSString stringWithFormat:@"%ld月前",temp];
        
    }else{
        
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return result;
}

@end
