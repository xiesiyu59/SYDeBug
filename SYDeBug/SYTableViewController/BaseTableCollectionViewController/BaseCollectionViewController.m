//
//  BaseCollectionViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/7.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong) MJRefreshNormalHeader *mjHeader;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *mjFooter;

// 2.设置是否是上拉
@property (nonatomic, assign) BOOL isFooterFresh;

@end

@implementation BaseCollectionViewController

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
    self.collectionView.sy_loadingView = [SYDefaultView loadingViewWithDefaultRefreshing];
    [self.collectionView.sy_loadingView beginRefreshing];
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.emptyDataSetDelegate = self;
    self.collectionView.emptyDataSetSource = self;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:UICollectionViewCell.className];
    //head
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeader.className];
    //footer
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:UICollectionElementKindSectionFooter.className];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, kScreenBottomIsX, 0));
    }];
    
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UICollectionViewCell.className forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 255/255.0 green:arc4random() % 255/255.0 blue:arc4random() % 255/255.0 alpha:1.0];
    return cell;
}

#pragma mark -UICollectionViewDelegateFlowLayout
//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = floor((kScreenWidth-45)/2);
    return CGSizeMake(width, width);
}

//间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 16, 0, 16);
}
//横向间距-上下
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
//纵向间距-左右
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

//headHeight
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kScreenWidth, CGFLOAT_MIN);
}
//footerHeight
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, CGFLOAT_MIN);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeader.className forIndexPath:indexPath];
        header.backgroundColor = [UIColor whiteColor];
        return header;
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:UICollectionElementKindSectionFooter.className forIndexPath:indexPath];
        footer.backgroundColor = [UIColor whiteColor];
        return footer;
    }
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
    
    self.collectionView.mj_header = self.mjHeader;
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
    
    self.collectionView.mj_footer = self.mjFooter;
    self.collectionView.mj_footer.hidden = YES;
}

- (MJRefreshAutoNormalFooter *)mjFooter{
    
    if (!_mjFooter) {
        _mjFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(mjFooterRefreshing)];
    }
    return _mjFooter;
}


- (void)beginRefreshing{
    
    if (self.collectionView && !self.collectionView.mj_header.isRefreshing) {
        [self.collectionView.mj_header beginRefreshing];
    }
}

- (void)endNetworkRereshing {
    
    if (self.collectionView.mj_header  && self.isFooterFresh == NO) {
        [self.collectionView.mj_header endRefreshing];
        
    }else if (self.collectionView.mj_footer && self.isFooterFresh){
        [self.collectionView.mj_footer endRefreshing];
    }
}

- (void)mjHeaderRefreshing {
    
    if (self.collectionView.mj_footer) {//这里需要重置一下上拉的状态
        [self.collectionView.mj_footer endRefreshing];
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
            
            self.collectionView.mj_footer.hidden = YES;
            self.dataArray = @[].mutableCopy;
            [self.collectionView reloadData];
            
        }else{
            
            self.collectionView.mj_footer.hidden = NO;
            self.dataArray = [NSMutableArray arrayWithArray:array];
            [self.collectionView reloadData];
        }
        
        [self.collectionView.sy_loadingView endRefreshing];
        [self.collectionView.mj_header endRefreshing];
        
    }else if (self.isFooterFresh && self.collectionView.mj_footer){//上拉
        if (array.count == 0) {

            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [self.collectionView.mj_footer resetNoMoreData];
            
            NSArray *tempArray = array;
            [self.dataArray addObjectsFromArray:tempArray];
            [self.collectionView reloadData];
            
        }
    }
    
}


- (void)dealloc{
    
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
}


@end
