//
//  UIView+SYDefaultView.h
//  MultiplexingFunction
//
//  Created by xiesiyu on 2018/2/10.
//  Copyright © 2018年 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SYDefaultView : UIView

/** 点击事件 */
@property (nonatomic, copy  ) void (^ _Nullable refreshingBlock)(void);

/** 活动指示器 */
+ (instancetype _Nullable)loadingViewWithDefaultRefreshing;
/** 错误缺省页 */
+ (instancetype _Nullable )loadingViewWithDefaultErrorMessage:(NSString *_Nullable)errorMessage;
/** 错误缺省页自定义图片 */
+ (instancetype _Nullable)loadingViewWithDefaultErrorMessage:(NSString *_Nullable)errorMessage imageName:(NSString *_Nullable)imageName;

/** 成功缺省页 */
+ (instancetype _Nullable )loadingViewWithDefaultRefreshingBlock:(void (^_Nullable)(void))refreshingBlock;

//** 偏移量 */
@property (nonatomic, assign) CGFloat offsetY;

//**缺省页字体颜色 *//
@property (nonatomic, strong) UIColor * _Nullable deftColor;

//** 是否重新加载视图 */
@property (nonatomic, assign) BOOL needAppear;
//** 是否隐藏错误视图 */
@property (nonatomic, assign) BOOL needHidenImage;
//** 是否禁止所有点击事件 */
@property (nonatomic, assign) BOOL needEnabled;


@property (nonatomic, strong)UIButton                * _Nullable defaultBgButton;   //缺省页背景点击
@property (nonatomic, strong)UIButton                * _Nullable defaultButton;    //缺省点击事件
@property (nonatomic, strong)UIButton                * _Nullable defaultLabelText; //缺省提示
@property (nonatomic, strong)UIActivityIndicatorView * _Nullable switchActivity;   //活动指示器


/** 开始刷新 */
- (void)beginRefreshing;

/** 结束刷新 */
- (void)endRefreshing;



/** 禁止点击 */
- (void)endRefreshingWithEnabledClick:(NSString *_Nullable)noEnabledString;

/** 没有数据 */
- (void)endRefreshingWithNoDataString:(NSString *_Nullable)noDataString;

/** 网络错误 */
- (void)endRefreshingWithErrorString:(NSString *_Nullable)errorString;

//** 自定义错误图片 */
- (void)endRefreshingWithNormalString:(NSString *_Nullable)normalString  normalImage:(UIImage *_Nullable)normalImage;

@end


@interface UIView (SYDefaultView)

@property (nonatomic, strong) SYDefaultView * _Nullable sy_loadingView;

@end
