//
//  ViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2019/10/29.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "ViewController.h"
#import "XibViewController.h"
#import "GoodsDetailViewController.h"
#import "FMDBVc.h"
#import "AmountCalculationVc.h"
#import "HomeVc.h"
#import "SYWkWebViewController.h"
#import "SwitchViewsController.h"
#import "YYCacheViewController.h"
#import "PPCounterViewController.h"
#import "UIViewController+RoutePush.h"
#import "PTSSYHomeHotMainController.h"
#import "CalendarViewController.h"

static NSString *identifier = @"cell";

@interface ViewController ()  <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *xsyTableView;
@property (nonatomic, strong)NSArray     *dataArray;

@end

@implementation ViewController

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (BOOL)sy_preferredNavigationBarHidden{
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"第一行",@"淘宝详情",@"FMDB",@"金额计算",@"首页样式",@"wkWebView",@"上下切换视图",@"YYCache",@"数字动画",@"ARC",@"文件下载",@"日历"];
    [self initWithInitialization];
}

#pragma mark - <初始化数据源>
- (void)initWithinitializationDataSource {
    
    
}

#pragma mark - <初始化界面>

- (void)initWithInitialization {
    
    self.xsyTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.xsyTableView.delegate = self;
    self.xsyTableView.dataSource = self;
    
    self.xsyTableView.tableFooterView = [UIView new];
    [self.xsyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.xsyTableView];
    [self.xsyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark -- <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray[indexPath.row];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //XibViewController //SYiCarouselViewController //FF14E7SViewController //CollectionViewController //SYGuideMaskViewController //LocationNoticeViewController  //SystemPhotoViewController  //SYIndexesViewController  //SYImageViewController  //SGPagingIndexVc
        //CodeInputViewController
        [self pushToViewControllerWithName:@"CodeInputViewController" param:nil];
        
    }else if (indexPath.row == 1){
        
        GoodsDetailViewController *vc = [[GoodsDetailViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        
        FMDBVc *vc = [[FMDBVc alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        
        AmountCalculationVc *vc = [[AmountCalculationVc alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4){
        
        //PTSSYHomeHotMainController //HomeVc
        [self pushToViewControllerWithName:@"HomeVc" param:nil];
        
    }else if (indexPath.row == 5){
        
        SYWkWebViewController *vc = [[SYWkWebViewController alloc] init];
        vc.urlString = @"www.baidu.com";
//        vc.contentString = @"asdasdsad";
//        vc.title = @"富文本";
        [self.navigationController pushViewController:vc animated:YES];
        
//        [self pushToViewControllerWithName:@"SYWkWebViewController" param:@{@"contentString":@"<p><br></p><p><img src=\"http://wlmq-metro-app.oss-cn-hangzhou.aliyuncs.com/xEnGCPtOaxXDpDDaAWpWgmRcSIdMj6c4KgGa9UqrMJ2zpX3nfl.gif\"></p><p><img src=\"http://wlmq-metro-app.oss-cn-hangzhou.aliyuncs.com/pfyq7Ilv4JjQBZQcFNFFDJtQDCyxU012EUQ3dDaIHkwAyHwQ8Z.gif\"></p><p><img src=\"http://wlmq-metro-app.oss-cn-hangzhou.aliyuncs.com/xYeia8OF4chYK1x4Ot412e86WbWjmNzkQVPJ7SFQDwArUNiUkn.gif\"></p>"}];
        
    }else if(indexPath.row == 6){
        
        SwitchViewsController *vc = [[SwitchViewsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 7){
        
        YYCacheViewController *vc = [[YYCacheViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 8){
        
        [self pushToViewControllerWithName:@"PPCounterViewController" param:@{@"userId":@"1",@"name":@"动态传参跳转"}];
    }else if (indexPath.row == 9){
        
        [self pushToViewControllerWithName:@"ARCViewController" param:nil];
//        [self pushToViewControllerWithName:@"openSafari" param:@{@"urlString":@"https://www.baidu.com"}];
    }else if (indexPath.row == 10){
        
        [self pushToViewControllerWithName:@"FileDownloadVc" param:nil];
    }else if (indexPath.row == 11){
        
        [self pushToViewControllerWithName:@"CalendarViewController" param:nil];
    }
    
    
}

@end
