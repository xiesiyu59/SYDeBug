//
//  InfoLeftViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/2/1.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "InfoLeftViewController.h"
#import "UIView+SYView.h"
#import "CodeInputViewController.h"
#import "SYSideMenuHeader.h"

@interface InfoLeftViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation InfoLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWithInitialization];
}

#pragma mark - <初始化数据源>
- (void)initWithinitializationDataSource {
    
    
}

#pragma mark - <初始化界面>

- (void)initWithInitialization {
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.backgroundColor = [UIColor lightGrayColor];
    [headerImageView setLXCornerdious:40];
    [headerView addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(16);
        make.centerY.equalTo(headerView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewCell.className];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 45, 0, 0));
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
    
    return 5;
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.sideMenuViewController hiddenAll];
    CodeInputViewController *vc = [[CodeInputViewController alloc] init];
    [[UIViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
}


@end
