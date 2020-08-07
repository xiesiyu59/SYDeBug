//
//  SYRefreshFooter.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/7/17.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SYRefreshFooter.h"

const MJRefreshState MJRefreshStateError = 6;


@interface SYRefreshFooter () {
    
    /** 显示刷新状态的label */
    __unsafe_unretained UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;


@end

@implementation SYRefreshFooter

+ (instancetype)footerHasTopSapceWithRefreshingBlock:(MJRefreshComponentAction)refreshingBlock {
    
    SYRefreshFooter *cmp = [[self alloc] init];
    cmp.hasTopSpace = NO;
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}

#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles {
    
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel {
    
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel mj_label]];
    }
    return _stateLabel;
}

- (UIActivityIndicatorView *)loadingView {
    
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
    
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state {
    
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

#pragma mark - 私有方法
- (void)stateLabelClick {
    
    if (self.state == MJRefreshStateIdle || self.state == MJRefreshStateError) {
        [self beginRefreshing];
    }
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) { // 新的父控件
        if (self.hidden == NO) {
            self.scrollView.mj_insetB += self.mj_h;
        }
        
        // 设置位置
        self.mj_y = _scrollView.mj_contentH;
    } else { // 被移除了
        if (self.hidden == NO) {
            self.scrollView.mj_insetB -= self.mj_h;
        }
    }
}


#pragma mark - 实现父类的方法
- (void)prepare {
    
    [super prepare];
    
//    self.backgroundColor = [UIColor whiteColor];
    
    if (self.hasTopSpace) {
        self.mj_h = 30;
    }else{
        self.mj_h = 40;
    }
    // 默认底部控件100%出现时才会自动刷新
    self.triggerAutomaticallyRefreshPercent = 1.0;
    
    // 设置为默认状态
    self.automaticallyRefresh = YES;
    
    
    
    //MARK: MJRefreshAutoStateFooter
    // 初始化间距
    self.labelLeftInset = MJRefreshLabelLeftInset;
    
    // 初始化文字
    [self setTitle:@"" forState:MJRefreshStateIdle];
    [self setTitle:@"" forState:MJRefreshStateRefreshing];
    [self setTitle:@"" forState:MJRefreshStateNoMoreData];
    [self setTitle:@"网络出错" forState:MJRefreshStateError];
    
    // 监听label
    self.stateLabel.userInteractionEnabled = YES;
    self.stateLabel.textColor = [UIColor lightGrayColor];
    [self.stateLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateLabelClick)]];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}


- (void)placeSubviews {
    
    [super placeSubviews];
    
    if (self.hasTopSpace) {
        
        if (self.stateLabel.constraints.count) return;
        
        // 状态标签
        CGRect rect = self.bounds;
        rect.origin.y -= 5;
        self.stateLabel.frame = rect;
        
        if (self.loadingView.constraints.count) return;
        
        // 圈圈
        CGFloat loadingCenterX = self.mj_w * 0.5;
        if (!self.isRefreshingTitleHidden) {
            //        loadingCenterX -= self.stateLabel.mj_textWith * 0.5 + self.labelLeftInset;
        }
        CGFloat loadingCenterY = self.mj_h * 0.5 - 5;
        self.loadingView.center = CGPointMake(loadingCenterX, loadingCenterY);
    }else{
        
        if (self.stateLabel.constraints.count) return;
        
        // 状态标签
        self.stateLabel.frame = self.bounds;
        
        if (self.loadingView.constraints.count) return;
        
        // 圈圈
        CGFloat loadingCenterX = self.mj_w * 0.5;
        if (!self.isRefreshingTitleHidden) {
            //        loadingCenterX -= self.stateLabel.mj_textWith * 0.5 + self.labelLeftInset;
        }
        CGFloat loadingCenterY = self.mj_h * 0.5;
        self.loadingView.center = CGPointMake(loadingCenterX, loadingCenterY);
    }
}

#pragma mark - 监听回调
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    
    [super scrollViewContentSizeDidChange:change];
    
    // 设置位置
    self.mj_y = self.scrollView.mj_contentH;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state != MJRefreshStateIdle || !self.automaticallyRefresh || self.mj_y == 0) return;
    
    if (_scrollView.mj_insetT + _scrollView.mj_contentH > _scrollView.mj_h) { // 内容超过一个屏幕
        // 这里的_scrollView.mj_contentH替换掉self.mj_y更为合理
        if (_scrollView.mj_offsetY >= _scrollView.mj_contentH - _scrollView.mj_h + self.mj_h * self.triggerAutomaticallyRefreshPercent + _scrollView.mj_insetB - self.mj_h) {
            // 防止手松开时连续调用
            CGPoint old = [change[@"old"] CGPointValue];
            CGPoint new = [change[@"new"] CGPointValue];
            if (new.y <= old.y) return;
            

            if (self.scrollView.isTracking || self.scrollView.isDecelerating || self.scrollView.isDragging) {
                // 当底部刷新控件完全出现时，才刷新
                [self beginRefreshing];
            }
        }
    }
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    
    [super scrollViewPanStateDidChange:change];
    
    if (self.state != MJRefreshStateIdle) return;
    
    if (_scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {// 手松开
        if (_scrollView.mj_insetT + _scrollView.mj_contentH <= _scrollView.mj_h) {  // 不够一个屏幕
            if (_scrollView.mj_offsetY >= - _scrollView.mj_insetT) { // 向上拽
                [self beginRefreshing];
            }
        } else { // 超出一个屏幕
            if (_scrollView.mj_offsetY >= _scrollView.mj_contentH + _scrollView.mj_insetB - _scrollView.mj_h) {
                [self beginRefreshing];
            }
        }
    }
}

//改变状态
- (void)setState:(MJRefreshState)state {
    
    MJRefreshCheckState
    
    if (state == MJRefreshStateRefreshing) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self executeRefreshingCallback];
        });
    } else if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle || state == MJRefreshStateError) {
        if (MJRefreshStateRefreshing == oldState) {
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }
    }
    
    if (self.isRefreshingTitleHidden && state == MJRefreshStateRefreshing) {
        self.stateLabel.text = nil;
    } else {
        self.stateLabel.text = self.stateTitles[@(state)];
    }
    
    // 根据状态做事情
    if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle || state == MJRefreshStateError) {
        [self.loadingView stopAnimating];
    } else if (state == MJRefreshStateRefreshing) {
        [self.loadingView startAnimating];
    }
    
    if (state == MJRefreshStateNoMoreData) {
        self.scrollView.mj_insetB = 0;
    }else{
        self.scrollView.mj_insetB = self.mj_h;
    }
}



- (void)setHidden:(BOOL)hidden {
    
    BOOL lastHidden = self.isHidden;
    
    [super setHidden:hidden];
    
    if (!lastHidden && hidden) {
        self.state = MJRefreshStateIdle;
        
        self.scrollView.mj_insetB -= self.mj_h;
    } else if (lastHidden && !hidden) {
        self.scrollView.mj_insetB += self.mj_h;
        
        // 设置位置
        self.mj_y = _scrollView.mj_contentH;
    }
}



@end


@implementation MJRefreshFooter (XCError)

- (void)endRefreshingWithError{
    
    self.state = MJRefreshStateError;
}


@end
