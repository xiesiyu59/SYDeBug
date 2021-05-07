//
//  UIView+SYDefaultView.m
//  MultiplexingFunction
//
//  Created by xiesiyu on 2018/2/10.
//  Copyright © 2018年 xiesiyu. All rights reserved.
//

#import "UIView+SYDefaultView.h"
#import <objc/runtime.h>
#import "UIView+MJExtension.h"

CGFloat const XSYSpace = 10;

@interface SYDefaultView ()


@end

@implementation SYDefaultView 

+ (instancetype)loadingViewWithDefaultErrorMessage:(NSString *)errorMessage {
    
    SYDefaultView *view = [[SYDefaultView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [view.defaultButton setBackgroundImage:[UIImage imageNamed:@"page_reminding_chucuo"] forState:UIControlStateNormal];
    [view.defaultLabelText setTitle:errorMessage forState:UIControlStateNormal];
    view.defaultButton.userInteractionEnabled = NO;
    
    return view;
    
}

+ (instancetype)loadingViewWithDefaultErrorMessage:(NSString *)errorMessage imageName:(NSString *)imageName{
    
    SYDefaultView *view = [[SYDefaultView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [view.defaultButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [view.defaultLabelText setTitle:errorMessage forState:UIControlStateNormal];
    view.defaultButton.userInteractionEnabled = NO;
    
    return view;
    
}

+ (instancetype)loadingViewWithDefaultRefreshingBlock:(void (^)(void))refreshingBlock {
    
    SYDefaultView *view = [[SYDefaultView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.refreshingBlock = refreshingBlock;
    view.defaultButton.userInteractionEnabled = YES;
    
    return view;
}


+ (instancetype)loadingViewWithDefaultRefreshing{
    
    SYDefaultView *view = [[SYDefaultView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.defaultButton.userInteractionEnabled = YES;
    return view;
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        _needAppear = YES;
    }
    return self;
}

//控件隐藏
- (void)controlHide{
    
    self.defaultButton.hidden = YES;
    self.defaultLabelText.hidden = YES;
    self.defaultBgButton.hidden = YES;
    
    [self.switchActivity startAnimating];
}
//控件显示
- (void)controlShow{
    
    self.defaultButton.hidden = NO;
    self.defaultLabelText.hidden = NO;
    self.defaultBgButton.hidden = NO;
    
    [self.switchActivity stopAnimating];
}

//开始刷新
- (void)beginRefreshing {
    
    if (_needAppear == NO) {
        return;
    }
    self.hidden = NO;
    [self controlHide];
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *tmp = (UIScrollView *)self.superview;
        tmp.scrollEnabled = NO;
    }
    
}

//成功结束
- (void)endRefreshing {
    
    _needAppear = NO;
    [self controlShow];
    self.hidden = YES;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *tmp = (UIScrollView *)self.superview;
        tmp.scrollEnabled = YES;
    }
    
}

//错误提示
- (void)endRefreshingWithString:(NSString *)error{
    
    if (_needAppear == NO) {
        return;
    }
    self.hidden = NO;
    [self controlShow];
    [self.defaultLabelText setTitle:error forState:UIControlStateNormal];
    
    _needAppear = YES;
    
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *tmp = (UIScrollView *)self.superview;
        tmp.scrollEnabled = NO;
    }
    
}


//没有数据禁止点击
- (void)endRefreshingWithEnabledClick:(NSString *)noEnabledString{
    
    self.defaultBgButton.userInteractionEnabled = NO;
    self.defaultButton.userInteractionEnabled = NO;
    self.defaultLabelText.userInteractionEnabled = NO;
    
    [self.defaultButton setBackgroundImage:[UIImage imageNamed:@"page_reminding_chucuo"] forState:UIControlStateNormal];
    [self endRefreshingWithString:noEnabledString?:@"您暂时没有相关数据"];
    
}

//没有数据可以刷新
- (void)endRefreshingWithNoDataString:(NSString *)noDataString{
    
    [self.defaultButton setBackgroundImage:[UIImage imageNamed:@"page_reminding_chucuo"] forState:UIControlStateNormal];
    [self endRefreshingWithString:noDataString?:@"您暂时没有相关数据"];
}

//网络错误可以刷新
- (void)endRefreshingWithErrorString:(NSString *)errorString{
    
    [self.defaultButton setBackgroundImage:[UIImage imageNamed:@"page_reminding_chucuo"] forState:UIControlStateNormal];
    [self endRefreshingWithString:errorString?:@"网络好像出错了"];
}

//自定义错误图片
- (void)endRefreshingWithNormalString:(NSString *)normalString  normalImage:(UIImage *)normalImage {
    
    self.defaultButton.userInteractionEnabled = NO;
    [self.defaultButton setImage:normalImage forState:UIControlStateNormal];
    [self endRefreshingWithString:normalString];
}


- (void)defaultButtonClick {
    
    if (self.refreshingBlock) {
        self.refreshingBlock();
    }
}


#pragma mark - Pravite Method
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = self.superview.bounds;
    rect.origin.y += _offsetY;
    rect.size.height -= _offsetY;
    self.frame = rect;
    [self placeSubviews];
}

- (void)placeSubviews{
    
    //活动指示器
    self.switchActivity.frame = self.bounds;
    
    CGSize imageViewSize = [UIImage imageNamed:@"page_reminding_chucuo.jpg"].size;
    
    CGSize labelSize = CGSizeMake(kScreenWidth-40, 30);
    CGFloat startY = (self.mj_h - imageViewSize.height - XSYSpace - labelSize.height)/2.f;
    
    //背景视图
    self.defaultBgButton.frame = self.bounds;
    //是否隐藏图片
    if (self.needHidenImage) {
        //提示文字视图
        self.defaultLabelText.frame = CGRectMake(0,
                                                 0,
                                                 labelSize.width,
                                                 labelSize.height);
        self.defaultLabelText.center = CGPointMake(CGRectGetMidX(self.switchActivity.frame), CGRectGetMidY(self.switchActivity.frame));
    }else{
        
        //图片视图
        self.defaultButton.frame = CGRectMake((self.mj_w - imageViewSize.width)/2.f,
                                              startY,
                                              imageViewSize.width,
                                              imageViewSize.height);
        
        self.defaultLabelText.frame = CGRectMake((self.mj_w - labelSize.width)/2.f,
                                                 startY + imageViewSize.height + XSYSpace,
                                                 labelSize.width,
                                                 labelSize.height);
    }
    
    //是否禁止点击事件
    if (self.needEnabled) {
        self.defaultBgButton.enabled = !self.needEnabled;
        self.defaultButton.enabled = !self.needEnabled;
        self.defaultLabelText.enabled = !self.needEnabled;
    }
    
}

#pragma mark - Views
- (UIActivityIndicatorView *)switchActivity{
    if (!_switchActivity) {
        
        _switchActivity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _switchActivity.hidesWhenStopped = YES;
        [self addSubview:_switchActivity];
    }
    return _switchActivity;
}


- (UIButton *)defaultBgButton{
    
    if (!_defaultBgButton) {
        
        _defaultBgButton = [[UIButton alloc] init];
        _defaultBgButton.adjustsImageWhenDisabled = NO;
        _defaultBgButton.adjustsImageWhenHighlighted = NO;
        [_defaultBgButton addTarget:self action:@selector(defaultButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_defaultBgButton];
    }
    return _defaultBgButton;
    
}

- (UIButton *)defaultButton {
    
    if (!_defaultButton) {
        
        _defaultButton = [[UIButton alloc] init];
        _defaultButton.adjustsImageWhenDisabled = NO;
        _defaultButton.adjustsImageWhenHighlighted = NO;
        [_defaultButton addTarget:self action:@selector(defaultButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_defaultButton];
    }
    return _defaultButton;
}

- (UIButton *)defaultLabelText {
    
    if (!_defaultLabelText) {
        
        _defaultLabelText = [[UIButton alloc] init];
        if (_deftColor != nil) {
            
            [_defaultLabelText setTitleColor:_deftColor forState:UIControlStateNormal];
            
        }else{
            
            [_defaultLabelText setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        
        _defaultLabelText.titleLabel.font = [UIFont systemFontOfSize:14];
        [_defaultLabelText addTarget:self action:@selector(defaultButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_defaultLabelText];
    }
    return _defaultLabelText;
    
    
}


@end


#pragma mark - XCLoadingView Category
const void* xyLoadingViewKey = "SYLoadingViewKey";
@implementation UIView (SYDefaultView)

- (void)setSy_loadingView:(SYDefaultView *)sy_loadingView {
    
    if (sy_loadingView != self.sy_loadingView) {
        // 删除旧的，添加新的
        [self.sy_loadingView removeFromSuperview];
        [self addSubview:sy_loadingView];
        
        // 存储新的
        objc_setAssociatedObject(self, xyLoadingViewKey, sy_loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
}

- (SYDefaultView *)sy_loadingView{
    
    return objc_getAssociatedObject(self, xyLoadingViewKey);
}

@end

