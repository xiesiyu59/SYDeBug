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
        make.top.equalTo(self.view).offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    
    
    CGSize size = CGSizeMake(300, 300);
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexString:@"#FFEDF9"];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(size);
    }];
    

    
    CGFloat width = size.width;
    CGFloat height = size.height;
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillRule = kCAFillRuleEvenOdd;
    layer.lineWidth = 0.5;
    layer.strokeColor = [UIColor blackColor].CGColor;  //外圈边线颜色
    layer.fillColor = [UIColor colorWithHexString:@"#D3F8FF"].CGColor;   //填充颜色


//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(height/2, 0)];
//    [path addArcWithCenter:CGPointMake(height/2, height/2) radius:height/2 startAngle:-M_PI*0.5 endAngle:-M_PI*1.5 clockwise:NO];
//    [path addLineToPoint:CGPointMake(width-(height/2), height)];
//    [path addArcWithCenter:CGPointMake(width-(height/2), height/2) radius:height/2 startAngle:-M_PI*1.5 endAngle:0 clockwise:NO];
//    [path addLineToPoint:CGPointMake(width, height/5)];
//    [path addQuadCurveToPoint:CGPointMake(width-(height/5), 0) controlPoint:CGPointMake(width, 0)];
//    [path addLineToPoint:CGPointMake(height/2, 0)];
//    [path closePath];
//    layer.path = path.CGPath;


    //直角边框
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, 0)];
//    [path addLineToPoint:CGPointMake(0, height)];
//    [path addLineToPoint:CGPointMake(width, height)];
//    [path addLineToPoint:CGPointMake(width, 0)];
//    [path closePath];
//    layer.path = path.CGPath;

//    左上角圆角
    UIBezierPath *path = [UIBezierPath bezierPath];

    [path moveToPoint:CGPointMake(0, 30)];
    [path addLineToPoint:CGPointMake(0, height)];
    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(width, 0)];
    [path addLineToPoint:CGPointMake(30, 0)];
    [path addQuadCurveToPoint:CGPointMake(0, 30) controlPoint:CGPointMake(0, 0)];

    [path closePath];
    layer.path = path.CGPath;



//    view.layer.borderColor = [UIColor blackColor].CGColor;
//    view.layer.backgroundColor = [UIColor yellowColor].CGColor;
    [view.layer addSublayer:layer];
    
    
    
    
}



- (void)buttonClick:(UIButton *)sender{
    
    [BRAddressPickerView showAddressPickerWithMode:BRAddressPickerModeArea dataSource:@[] selectIndexs:0 isAutoSelect:NO resultBlock:^(BRProvinceModel * _Nullable province, BRCityModel * _Nullable city, BRAreaModel * _Nullable area) {
        NSLog(@"%@--%@--%@",province.name,city.name,area.name);
        NSLog(@"%@--%@--%@",province.code,city.code,area.code);
    }];
    
}

@end
