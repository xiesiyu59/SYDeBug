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

static NSString *identifier = @"cell";


@interface HomeVc () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)TableView *xsyTableView;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, assign)NSInteger indexPage;
@property (nonatomic, assign)NSInteger statusTag;


@end

@implementation HomeVc {
    
    CGFloat kHeaderImageHeight;
    
}


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
        kHeaderImageHeight = [UIScreen mainScreen].bounds.size.width/16.f*9;
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.indexPage = 1;
    self.statusTag = 0;
    [self initWithInitialization];
    [self initWithinitializationDataSourceFooter:NO];
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
    self.xsyTableView.contentInset = UIEdgeInsetsMake(kHeaderImageHeight, 0, 0, 0);
    self.xsyTableView.delegate = self;
    self.xsyTableView.dataSource = self;
    self.xsyTableView.tableFooterView = [UIView new];
    [self.xsyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    [self.view addSubview:self.xsyTableView];
    [self.xsyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.headerView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.xsyTableView.mas_width);
        make.height.mas_equalTo(kHeaderImageHeight);
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
    
    
    self.xsyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self initWithinitializationDataSourceFooter:NO];
    }];
    
    SYRefreshFooter *footer = [SYRefreshFooter footerHasTopSapceWithRefreshingBlock:^{
        [self initWithinitializationDataSourceFooter:YES];
    }];
//    footer.hasTopSpace = 40;
    self.xsyTableView.mj_footer = footer;
    
    

    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"y is %0.f",y);
    if (y >= 0) {
        self.headerView.mj_y = -kHeaderImageHeight;
    }else if (y <= -kHeaderImageHeight){
        self.headerView.mj_y = 0;
    }else{
        self.headerView.mj_y = -y - kHeaderImageHeight;
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
    
    NSLog(@"点击");
    [self screen];
}

@end
