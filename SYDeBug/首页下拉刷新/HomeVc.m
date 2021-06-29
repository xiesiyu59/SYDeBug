//
//  HomeVc.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/2/11.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "HomeVc.h"
#import "UIView+MJExtension.h"
#import "SYRefreshFooter.h"
#import "TableView.h"
#import "SYProgressHUD.h"
#import "SYToast.h"


static NSString *identifier = @"cell";


@interface HomeVc () <UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)TableView *xsyTableView;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, assign)NSInteger indexPage;
@property (nonatomic, assign)NSInteger statusTag;
@property (nonatomic, assign)CGFloat kHeaderImageHeight;


@end

@implementation HomeVc


- (BOOL)sy_preferredNavigationBarHidden{
    return YES;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)init{
    if (self = [super init]) {
        self.kHeaderImageHeight = [UIScreen mainScreen].bounds.size.width/16.f*9;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.indexPage = 1;
    self.statusTag = 0;
    [self initWithInitialization];
    
    
}

#pragma mark - <初始化数据源>
- (void)initWithinitializationDataSourceFooter:(BOOL)footer {
    
    if (!footer) {
        self.indexPage = 1;
        
        self.dataArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3"]];
        
        [self.xsyTableView.mj_footer resetNoMoreData];
        [self.xsyTableView.mj_header endRefreshing];
        [self.xsyTableView reloadData];
        
    }else{
        
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (self.indexPage == 2) {
                [self.xsyTableView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            [self.dataArray addObjectsFromArray:@[@"1",@"2",@"3",@"4",@"5"]];
            self.indexPage++;
            [self.xsyTableView.mj_footer endRefreshing];
            [self.xsyTableView reloadData];
        });
    }
}




#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    
    self.xsyTableView = [[TableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.xsyTableView.contentInset = UIEdgeInsetsMake(self.kHeaderImageHeight, 0, 0, 0);
    self.xsyTableView.delegate = self;
    self.xsyTableView.dataSource = self;
    self.xsyTableView.tableFooterView = [UIView new];
    [self.xsyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    [self.view addSubview:self.xsyTableView];
    [self.xsyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.xsyTableView.emptyDataSetDelegate = self;
    self.xsyTableView.emptyDataSetSource = self;
    
    
   
    self.headerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.headerView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.xsyTableView.mas_width);
        make.height.mas_equalTo(self.kHeaderImageHeight);
    }];
    
    
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView).offset(40);
        make.left.equalTo(self.headerView).offset(16);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        
    }];
    
    
    __weak __typeof__(self) weakSelf = self;
    self.xsyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf initWithinitializationDataSourceFooter:NO];
    }];
    
    SYRefreshFooter *footer = [SYRefreshFooter footerHasTopSapceWithRefreshingBlock:^{
        [weakSelf initWithinitializationDataSourceFooter:YES];
    }];
//    footer.hasTopSpace = 40;
    self.xsyTableView.mj_footer = footer;
    
    

    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"y is %0.f",y);
    if (y >= 0) {
        self.headerView.mj_y = -self.kHeaderImageHeight;
    }else if (y <= -self.kHeaderImageHeight){
        self.headerView.mj_y = 0;
    }else{
        self.headerView.mj_y = -y - self.kHeaderImageHeight;
    }
    
    if (self.xsyTableView.mj_header.state == MJRefreshStatePulling) {
        
        if (self.statusTag == 0) {
            UIImpactFeedbackGenerator *impactFeedBack = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
            [impactFeedBack prepare];
            [impactFeedBack impactOccurred];
        }
        self.statusTag++;
    }else{
        self.statusTag = 0;
    }
}


#pragma mark -- <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


//Header
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

- (void)buttonClick:(UIButton *)sender{
    
    [SYToast showWithMessage:@"转"];
    [self sy_screenFlip];
}


#pragma mark - DZNEmptyDataSetSource
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return IMG(@"page_reminding_chucuo");
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无数据";
    NSDictionary *attributes = @{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
        NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#575757"]
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}


- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {

    NSString *text = @"暂无数据，可能是因为某些未知原因";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;

    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName:paragraph
                                 };

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {

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

//- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
//    return IMG(@"liu");
//}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    //刷新数据
    [self initWithinitializationDataSourceFooter:NO];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return kScreenTopIsX;
}


@end
