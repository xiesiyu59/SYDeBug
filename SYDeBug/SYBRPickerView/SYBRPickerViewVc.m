//
//  SYBRPickerViewVc.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/3/29.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYBRPickerViewVc.h"

@interface SYBRPickerViewVc ()

@end

@implementation SYBRPickerViewVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithInitialization];
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
}

- (void)buttonClick:(UIButton *)sender{
    
    [BRAddressPickerView showAddressPickerWithMode:BRAddressPickerModeArea dataSource:@[] selectIndexs:0 isAutoSelect:NO resultBlock:^(BRProvinceModel * _Nullable province, BRCityModel * _Nullable city, BRAreaModel * _Nullable area) {
        NSLog(@"%@--%@--%@",province.name,city.name,area.name);
        NSLog(@"%@--%@--%@",province.code,city.code,area.code);
    }];
    
}

@end
