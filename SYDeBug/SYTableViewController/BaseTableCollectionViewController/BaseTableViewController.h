//
//  BaseTableViewController.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/7.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+SYDefaultView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseViewController 


@property (nonatomic, strong)UITableView       *tableView;
@property (nonatomic, strong)NSMutableArray    *dataArray;
@property (nonatomic, assign)NSInteger         pageIndex;


// 添加上拉或下拉
- (void)addHeaderRefresh;
- (void)addFooterRefresh;
- (void)beginRefreshing;
- (void)activityIndicatorViewBegin;

//// 如果是tableView 则会判断是否有数据 并结束下拉或上拉提示 - 刷新
- (void)updateDataSource:(NSArray *)array;


#pragma mark - 网咯请求

//// 下拉刷新的网络请求 设置了 AddHeaderRefresh 方法在子类实现该方法
- (void)networkRereshing;
//// 结束刷新（结束上下拉刷新）
- (void)endNetworkRereshing;

@end

NS_ASSUME_NONNULL_END
