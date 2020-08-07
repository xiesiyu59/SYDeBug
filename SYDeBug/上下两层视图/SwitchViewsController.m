//
//  SwitchViewsController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/5/22.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SwitchViewsController.h"
#import "UIView+MJExtension.h"
#import <AudioToolbox/AudioToolbox.h>

static NSString *identifier = @"cell";
static NSString *topIdentifier = @"TopCell";

@interface SwitchViewsController () <UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *bottomTableView;
@property (nonatomic, strong)UITableView *topTableView;
@property (nonatomic, assign)NSInteger statusTag;

@end

@implementation SwitchViewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上下切换";
    [self initWithInitialization];
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    
    self.bottomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kScreenTopIsX) style:UITableViewStylePlain];
    self.bottomTableView.backgroundColor = [UIColor orangeColor];
    self.bottomTableView.delegate = self;
    self.bottomTableView.dataSource = self;
    
    self.bottomTableView.tableFooterView = [UIView new];
    [self.bottomTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.bottomTableView];
    
    
    
    
    self.topTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kScreenTopIsX) style:UITableViewStylePlain];
    self.topTableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    self.topTableView.backgroundColor = [UIColor clearColor];
    self.topTableView.delegate = self;
    self.topTableView.dataSource = self;

    self.topTableView.tableFooterView = [UIView new];
    [self.topTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:topIdentifier];
    [self.view addSubview:self.topTableView];
    
    self.topTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        
    }];
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    if (self.topTableView == scrollView) {
        if (y >= 0) {
            self.bottomTableView.mj_y = -100;
        }else if (y <= -100){
            self.bottomTableView.mj_y = 0;
        }else{
            self.bottomTableView.mj_y = -y -100;
        }
    }
    
    if (self.topTableView.mj_header.state == MJRefreshStatePulling) {
        
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

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    NSLog(@"scrollViewWillEndDragging");
    CGFloat y = scrollView.contentOffset.y;
    if (self.bottomTableView == scrollView) {
        NSLog(@"bottom:y is %0.f",y);
        if (y >= 100) {
            
            [UIView animateWithDuration:0.3 animations:^{
                self.topTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kScreenTopIsX);
            } completion:^(BOOL finished) {
                
            }];
        }
    }else{
        NSLog(@"top:y is %0.f",y);
        if (y < -160) {
            
            [UIView animateWithDuration:0.5 animations:^{
                self.topTableView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight-kScreenTopIsX);
            } completion:^(BOOL finished) {
                [self.topTableView.mj_header endRefreshing];
            }];
        }
    }
}




#pragma mark -- <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.bottomTableView == tableView) {
         return 5;
    }else{
       return 5;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.bottomTableView == tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"底部%ld",indexPath.row];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"顶部%ld",indexPath.row];
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



@end
