//
//  SYRefreshFooter.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/7/17.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

extern const MJRefreshState MJRefreshStateError;

@interface SYRefreshFooter : MJRefreshFooter

/** 是否自动刷新(默认为YES) */
@property (assign, nonatomic, getter=isAutomaticallyRefresh) BOOL automaticallyRefresh;

/** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
@property (assign, nonatomic) CGFloat triggerAutomaticallyRefreshPercent;


/** 文字距离圈圈、箭头的距离 */
@property (assign, nonatomic) CGFloat labelLeftInset;
/** 显示刷新状态的label */
@property (weak, nonatomic, readonly) UILabel *stateLabel;
/** 是否向上偏移 */
@property (nonatomic, assign) BOOL hasTopSpace;


/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state;

/** 隐藏刷新状态的文字 */
@property (assign, nonatomic, getter=isRefreshingTitleHidden) BOOL refreshingTitleHidden;

/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

+ (instancetype)footerHasTopSapceWithRefreshingBlock:(MJRefreshComponentAction)refreshingBlock;


@end



@interface MJRefreshFooter (XCError)

- (void)endRefreshingWithError;

@end


NS_ASSUME_NONNULL_END
