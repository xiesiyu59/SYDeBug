//
//  SYIndexesViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/1/8.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYIndexesViewController.h"

@interface SYIndexesViewController ()  <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *indexArray;

@end

@implementation SYIndexesViewController

- (NSMutableArray *)indexArray{
    if (!_indexArray) {
        _indexArray = [NSMutableArray array];
    }
    return _indexArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithInitialization];
    [self initWithinitializationDataSource];
}

#pragma mark - <初始化数据源>
- (void)initWithinitializationDataSource {
    
    self.dataArray =  @[@[@"A",@"AB",@"ABC"],@[@"B",@"BDF"],@[@"C",@"CDS",@"CGF"],@[@"D",@"DSE",@"DST"],@[@"E",@"EFD"],@[@"F",@"FDSD",@"FSFDS"],
                        @[@"G",@"GSDSD",@"GQWE",@"GDSA"],@[@"H",@"HTYA",@"HSYAD",@"HSADA"],@[@"I",@"IAA",@"IASDA"],@[@"J"]];
    for (NSArray *array in self.dataArray) {
        [self.indexArray addObject:array.firstObject];
    }
    [self.tableView reloadData];
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionIndexBackgroundColor =[UIColor whiteColor];
    self.tableView.sectionIndexColor = [UIColor blackColor];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewCell.className];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -- <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArray[section] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.className forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];

    return cell;
}


//Head
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    headerView.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [BaseClassTool labelWithFont:18 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    label.text = [self.indexArray copy][section];
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView.mas_centerY);
        make.left.equalTo(headerView).offset(16);
    }];
    
    return headerView;
}

//Footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return [self.indexArray copy];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [self.indexArray copy][section];
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index{
    
    NSLog(@"%@--%ld",title,(long)index);
    return index;
   
}

@end
