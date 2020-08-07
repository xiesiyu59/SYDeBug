//
//  GoodsDetailLayout.h
//  SYDeBug
//
//  Created by xiesiyu on 2019/11/11.
//  Copyright © 2019 xiesiyu. All rights reserved.
//


/*
 
 使用说明：1、TableHeaderView为tableView表头视图,在xib中根据实际情况自定义
 2、DetailCell为tableView的item,在xib中根据实际情况自定义
 1、OnPullMsgView为上拉加载图文详情视图，在xib中根据实际情况自定义
 1、DownPullMsgView为下拉显示商品详情视图，在xib中根据实际情况自定义
 
 注意：在.m文件中自行实现tableView的代理方法代码，因为此处涉及到滚动监听，难以将代理传入给控制器！
 */

//拖拽的高度
#define KendDragHeight 60.0
//提示上下拉视图的高度
#define KmsgVIewHeight 40.0

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "GoodsDetailHeaderView.h"
#import "GoodsDetailCell.h"
#import "OnPullMsgView.h"
#import "DownPullMsgView.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^ScrollScreenBlock)(BOOL isFirst);

@interface GoodsDetailLayout : UIView

/**
 实例方法
 
 @param viewController    传入当前控制器
 @param webViewURL        图文详情的html地址
 @param isConverAnimation 是否需要滚动视图差动画
 @param bottomHeight 底部视图需要的高度--放置“立即购买的”位置
 */
-(void)setGoodsDetailLayout:(UIViewController*)viewController WebViewURL:(NSString*)webViewURL isConverAnimation:(BOOL)isConverAnimation bottomHeighr:(CGFloat)bottomHeight;

//滚动监听Block:为YES是滚动到了商品详情 NO滚动到图文详情
@property (nonatomic, copy) ScrollScreenBlock scrollScreenBlock;


@end

NS_ASSUME_NONNULL_END
