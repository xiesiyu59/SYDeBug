//
//  AmountCalculationVc.m
//  SYDeBug
//
//  Created by xiesiyu on 2019/11/22.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "AmountCalculationVc.h"
#import "NSString+AmountCalculation.h"

@interface AmountCalculationVc ()

@property (nonatomic, assign)NSInteger number;
@property (nonatomic, strong)UILabel *showLabel;

@end

@implementation AmountCalculationVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithInitialization];
}

- (UILabel *)showLabel{
    if (!_showLabel) {
        _showLabel = [[UILabel alloc] init];
        _showLabel.numberOfLines = 0;
        _showLabel.backgroundColor = [UIColor lightGrayColor];
        _showLabel.textColor = [UIColor blackColor];
        _showLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _showLabel;
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    
    self.number = 1;
    

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"数量减" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.backgroundColor = [UIColor orangeColor];
    leftButton.tag = 0;
    [leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScreenTopIsX);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth/2);
    }];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"数量加" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor orangeColor];
    rightButton.tag = 1;
    [rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.view).offset(kScreenTopIsX);
       make.right.equalTo(self.view.mas_right);
       make.width.mas_equalTo(kScreenWidth/2);
    }];
    
    [self.view addSubview:self.showLabel];
    [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftButton.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    [manager startMonitoring];
//    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown:{
//                //未知网络
//                NSLog(@"未知网络");
//            }break;
//            case AFNetworkReachabilityStatusNotReachable:{
//                //无法联网
//                NSLog(@"无法联网");
//            }break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:{
//                //手机自带网络
//                NSLog(@"当前使用的是2g/3g/4g网络");
//
//            }break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:{
//                //WIFI
//                NSLog(@"当前在WIFI网络下");
//
//            }break;
//        }
//    }];
    
    
//统计一个字符串出现频率最高的字母或者数字
//    NSString *string = @"asdfjkalsdjflkajskldfjalkdsjflkasd5657567fjlajslfdl";
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    for (NSInteger i = 0; i < string.length; i ++) {
//        NSString *temp = [string substringWithRange:NSMakeRange(i, 1)];
//        if (![dict containsObjectForKey:temp]) {
//            [dict setObject:@(1) forKey:temp];
//        }else{
//            NSInteger tempIndex = [dict[temp] integerValue] + 1;
//            [dict setObject:@(tempIndex) forKey:temp];
//        }
//    }
//    NSLog(@"%@",dict);
    
    
//找出整型数组里乘积最大的三个数
//    NSArray *integerArray = @[@(-10),@(7),@(29),@(30),@(5),@(-10),@(-70)];
//    NSInteger maxValue = 0;
//    for (NSInteger i = 0; i < integerArray.count; i ++) {
//        NSInteger tempi = [integerArray[i] integerValue];
//        for (NSInteger j = 0; j < integerArray.count; j ++) {
//            NSInteger tempj = [integerArray[j] integerValue];
//            for (NSInteger k = 0; k < integerArray.count; k++) {
//                NSInteger tempk = [integerArray[k] integerValue];
//
//                if (j == k || i == j || i == k) {
//                    continue;
//                }
//                NSInteger maxInteget = tempi*tempj*tempk;
//                if (maxInteget > maxValue) {
//                    maxValue = maxInteget;
//                    NSLog(@"%ld",maxInteget);
//                    NSLog(@"%ld   %ld   %ld",tempi,tempj,tempk);
//                }
//            }
//        }
//    }
    
    
//假设有n级台阶 每次最多允许跨m步 (m<=n) 那么有多少种跨越方式;

    
    
}


- (void)buttonClick:(UIButton *)sender{
    
    NSString *price = @"15.45";
    NSString *discount = @"10";
    
    NSString *showString;
    NSString *disString;
    
    if (sender.tag == 0) {
        self.number--;
    }else if (sender.tag == 1){
        self.number++;
    }
    //乘算
    showString = [NSString amountCalculationType:2 ln:price rn:[NSString stringWithFormat:@"%ld",self.number]];
    //折扣减算
    disString = [NSString amountCalculationType:1 ln:showString rn:discount];
    
    //money*1-(折扣)
//    NSString *showStringTwo = [NSString multiplication:@"17.35" rightNumber:@"9"];
//    NSString *fentan = [NSString division:@"156" rightNumber:@"9"];
//    NSLog(@"%@", showStringTwo);
//    NSLog(@"%@",fentan);
//    showString = [NSString amountCalculationType:3 ln:@"156" rn:@"9"];
    self.showLabel.text = [NSString stringWithFormat:@"￥%.2f",[disString doubleValue]];
    
}


@end
