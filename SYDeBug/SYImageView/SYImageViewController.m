//
//  SYImageViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/1/12.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYImageViewController.h"
#import "UIImage+SYGradualImage.h"
#import "UIImage+SYQRImage.h"
#import <UIColor+YYAdd.h>

@interface SYImageViewController ()

@end

@implementation SYImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initWithInitialization];
    
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    UIImage *qrImage = [UIImage qrCodeImageWithContent:@"我是二维码" width:200 padding:0 red:255 green:255 blue:255];
    
    UIImage *gradualImage = [UIImage createImageWithSize:CGSizeMake(200, 200) gradientColors:@[[UIColor colorWithHexString:@"00FFFF"],[UIColor colorWithHexString:@"00FA9A"]] percentage:@[@0,@1] gradientType:GradientFromLeftToRight];
    
    UIImageView *qrImageView = [[UIImageView alloc] init];
    qrImageView.image = gradualImage;
    [self.view addSubview:qrImageView];
    [qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    
    
    
}



@end
