//
//  BaseTableViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/7.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "BaseTableViewController.h"



@interface BaseTableViewController () <UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong) MJRefreshNormalHeader *mjHeader;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *mjFooter;

// 2.设置是否是上拉
@property (nonatomic, assign) BOOL isFooterFresh;

@end

@implementation BaseTableViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithInitialization];
    [self activityIndicatorViewBegin];
    
}

//活动指示器
- (void)activityIndicatorViewBegin{
    
    self.pageIndex = 1;
    self.tableView.sy_loadingView = [SYDefaultView loadingViewWithDefaultRefreshing];
    [self.tableView.sy_loadingView beginRefreshing];
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewCell.className];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, kScreenBottomIsX, 0));
    }];
    
}

#pragma mark -- <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.className forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//Head
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

//Footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}


#pragma mark - DZNEmptyDataSetSource
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return IMG(@"page_reminding_chucuo");
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    //错误标题
    NSString *title = @"";
    NSDictionary *attributes = @{
        NSFontAttributeName:[UIFont systemFontOfSize:16],
        NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#575757"]
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {

    //错误点击
    NSString *text = @"网络不给力，请点击重试哦~";
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    //设置所有字体大小为 #15
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:15.0]
                   range:NSMakeRange(0, text.length)];
    //设置所有字体颜色为浅灰色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:[UIColor lightGrayColor]
                   range:NSMakeRange(0, text.length)];
    //设置指定4个字体为蓝色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:[UIColor colorWithHexString:@"#007EE5"]
                   range:NSMakeRange(7, 4)];
    return attStr;
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    //刷新数据
    
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    //点击空白页
    
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return 0;
}

#pragma mark - MJRefresh
- (void)addHeaderRefresh{
    
    self.tableView.mj_header = self.mjHeader;
}
- (MJRefreshNormalHeader *)mjHeader{
    
    if (!_mjHeader) {
        _mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(mjHeaderRefreshing)];
    }
    return _mjHeader;
}

- (void)addFooterRefresh{
    
    [self.mjFooter setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [self.mjFooter setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [self.mjFooter setTitle:@"没有更多啦 _(:* ｣∠)_" forState:MJRefreshStateNoMoreData];
    self.mjFooter.stateLabel.font = [UIFont systemFontOfSize:15];
    self.mjFooter.stateLabel.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    
    self.tableView.mj_footer = self.mjFooter;
    self.tableView.mj_footer.hidden = YES;
}

- (MJRefreshAutoNormalFooter *)mjFooter{
    
    if (!_mjFooter) {
        _mjFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(mjFooterRefreshing)];
    }
    return _mjFooter;
}


- (void)beginRefreshing{
    
    if (self.tableView && !self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)endNetworkRereshing {
    
    if (self.tableView.mj_header  && self.isFooterFresh == NO) {
        [self.tableView.mj_header endRefreshing];
        
    }else if (self.tableView.mj_footer && self.isFooterFresh){
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)mjHeaderRefreshing {
    
    if (self.tableView.mj_footer) {//这里需要重置一下上拉的状态
        [self.tableView.mj_footer endRefreshing];
    }

    self.pageIndex = 1;
    self.isFooterFresh = NO;
    [self networkRereshing];
}

- (void)mjFooterRefreshing {
    
    self.pageIndex ++;
    self.isFooterFresh = YES;
    [self networkRereshing];
}

- (void)networkRereshing{
    //需要子类具体实现
    
}

- (void)updateDataSource:(NSArray *)array{
    
    if (self.isFooterFresh == NO ){//下拉
        if (array.count == 0) {
            
            self.tableView.mj_footer.hidden = YES;
            self.dataArray = @[].mutableCopy;
            [self.tableView reloadData];
            
        }else{
            
            self.tableView.mj_footer.hidden = NO;
            self.dataArray = [NSMutableArray arrayWithArray:array];
            [self.tableView reloadData];
        }
        
        [self.tableView.sy_loadingView endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
    }else if (self.isFooterFresh && self.tableView.mj_footer){//上拉
        if (array.count == 0) {

            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [self.tableView.mj_footer resetNoMoreData];
            
            NSArray *tempArray = array;
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
            
        }
    }
    
}


- (void)dealloc{
    
    self.tableView.editing = NO;
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}


@end
