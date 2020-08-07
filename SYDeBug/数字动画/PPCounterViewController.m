//
//  PPCounterViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/5/25.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "PPCounterViewController.h"
#import "NumberAnimation.h"

@interface PPCounterViewController ()

@end

@implementation PPCounterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithInitialization];
    NSLog(@"%@---%@",self.userId,self.name);
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    UILabel *leftButton = [[UILabel alloc] init];
    leftButton.textAlignment = NSTextAlignmentCenter;
    leftButton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScreenTopIsX);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    [NumberAnimation numAnimationControl:leftButton start:@"0" end:@"200" type:1];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"读取" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScreenTopIsX);
        make.left.equalTo(leftButton.mas_right);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    [NumberAnimation numAnimationControl:rightButton start:@"0" end:@"200" type:1];
}

@end
