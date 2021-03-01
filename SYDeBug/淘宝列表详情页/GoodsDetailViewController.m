//
//  GoodsDetailViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2019/11/11.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsDetailLayout.h"

@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (BOOL)sy_interactivePopDisabled{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化实例
    GoodsDetailLayout *detailView = [[GoodsDetailLayout alloc]init];
    //调用方法
    [detailView setGoodsDetailLayout:self WebViewURL:@"https://www.baidu.com" isConverAnimation:YES bottomHeighr:49];
    //滚动监听
    detailView.scrollScreenBlock = ^(BOOL isFirst){
        if (isFirst) {
            NSLog(@"滚动到了第一屏");
        }else{
            NSLog(@"第二屏");
        }
    };
    
    UIView *buyView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kScreenTopIsX-49, kScreenWidth, 49)];
    buyView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:buyView];
    
}

@end
