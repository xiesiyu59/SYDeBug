//
//  PTSSYHomeHotMainController.m
//  PetStore
//
//  Created by xiesiyu on 2020/6/3.
//  Copyright © 2020 Petstore. All rights reserved.
//

#import "PTSSYHomeHotMainController.h"
#import "JPVideoPlayerKit.h"
#import "PTSSYHomeHotMainCell.h"
#import "SYVideoPlayerProgressView.h"



@interface PTSSYHomeHotMainController () <JPScrollViewPlayVideoDelegate,UITableViewDelegate,UITableViewDataSource,PTSSYHomeHotMainCellDelegate>


@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *sourceArray;
@property (nonatomic, strong) UITableView *xsyTableView;
@property (nonatomic, assign) NSInteger curPageIndex;


@property (nonatomic, assign) BOOL muteOpen;                    //音量控制
@property (nonatomic, assign) BOOL isSuspend;                   //暂停控制

@property (nonatomic, strong)PTSSYHomeHotMainCell *suspendCell;


@end

@implementation PTSSYHomeHotMainController

- (void)dealloc {
    if (self.xsyTableView.jp_playingVideoCell) {
        [self.xsyTableView.jp_playingVideoCell.jp_videoPlayView jp_stopPlay];
    }
}

- (instancetype)initWithPlayStrategyType:(JPScrollPlayStrategyType)playStrategyType {
    self = [super init];
    if(self){
        _scrollPlayStrategyType = playStrategyType;
    }
    return self;
}

- (NSArray*)sourceArray{
    if (!_sourceArray) {
        _sourceArray = [NSArray array];
    }
    return _sourceArray;;
}
- (NSArray*)imageArray{
    if (!_imageArray) {
        _imageArray = [NSArray array];
    }
    return _imageArray;;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.curPageIndex = 1;
    self.muteOpen = NO;
    self.isSuspend = NO;
    
    [self initWithInitialization];
    [self initWithinitializationDataSource];
    
}


#pragma mark - <初始化数据源>
- (void)initWithinitializationDataSource {
    
    self.sourceArray = @[@"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200602\/9329134a9d8b1c9f1c51a00456032c5a.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200602\/4952ec89930d47784d7210a76f1f98d7.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200602\/a333028c97d32646ff956211f79f03de.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200602\/4ec64aef15ceb8ddd9d39c4b743b0921.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200602\/17ac9464d618ac5d157aa250c2693d19.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200602\/2b372779c00e8c17de2f152dde75e77d.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200513\/af15fa6fdfe2bb5925367095519e56ca.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200514\/7064afb0814e861bddbf88a0a4f739b4.mp4"
                         
    ];
    
    self.imageArray= @[@"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200602\/fb6628722edd42a4f9a01fe0bce51718.jpg?w=720&h=1280",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200602\/38526e0920189c5e4ac5323f77ffd09c.jpg?w=720&h=1280",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200602\/e44651f4142b13d6ebe53d73ee723228.jpg?w=720&h=1280",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200602\/c7e0c77a8f66366a8c6a3345f62d154a.jpg?w=720&h=1280",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200602\/d93ede141c68f12327a894f749eb05b6.jpg?w=544&h=960",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200602\/cc1d1a538165520eb5321f6d8a383918.jpg?w=592&h=1280",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200513\/4bf1233acb278be65a1f1cbbc855cbd7.jpg?w=720&h=1280",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200514\/4e4383a55cd9ae89efd0640f6d7dba08.jpg?w=720&h=1280"
    ];
    
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    self.xsyTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.xsyTableView.delegate = self;
    self.xsyTableView.dataSource = self;
    
    self.xsyTableView.tableFooterView = [UIView new];
    [self.xsyTableView registerClass:[PTSSYHomeHotMainCell class] forCellReuseIdentifier:@"PTSSYHomeHotMainCell"];
    [self.xsyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [self.view addSubview:self.xsyTableView];
    [self.xsyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.xsyTableView.jp_delegate = self;
    self.xsyTableView.jp_scrollPlayStrategyType = self.scrollPlayStrategyType;
    
}

#pragma mark -- <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kScreenWidth;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 4 || indexPath.section == 6) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = @"文字";
        return cell;;
        
    }
    
    PTSSYHomeHotMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTSSYHomeHotMainCell" forIndexPath:indexPath];
    cell.delegate = self;
    
    [cell.videoPlayView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[indexPath.section]]];
    cell.indexPath = indexPath;
    cell.jp_videoURL = [NSURL URLWithString:self.sourceArray[indexPath.section]];
    cell.jp_videoPlayView = cell.videoPlayView;
    
    
    [tableView jp_handleCellUnreachableTypeForCell:cell
                                       atIndexPath:indexPath];
    
    cell.muteButton.selected = self.muteOpen;
    cell.muteBlock = ^(BOOL isOpen) {
        self.muteOpen = isOpen;
        
        [self.xsyTableView reloadData];
        [self.xsyTableView jp_handleCellUnreachableTypeInVisibleCellsAfterReloadData];
        [self.xsyTableView jp_playVideoInVisibleCellsIfNeed];
        
    };
    
    return cell;
    
}

//Head
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    return headerView;
}

//Footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    return footerView;
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect tableViewFrame = self.xsyTableView.frame;
    tableViewFrame.size.height -= self.tabBarController.tabBar.bounds.size.height;
    self.xsyTableView.jp_scrollViewVisibleFrame = tableViewFrame;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.xsyTableView jp_handleCellUnreachableTypeInVisibleCellsAfterReloadData];
    [self.xsyTableView jp_playVideoInVisibleCellsIfNeed];
    // 用来防止选中 cell push 到下个控制器时, scrollView 再次调用 scrollViewDidScroll 方法, 造成 playingVideoCell 被置空.
    self.xsyTableView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // 用来防止选中 cell push 到下个控制器时, scrollView 再次调用 scrollViewDidScroll 方法, 造成 playingVideoCell 被置空.
    self.xsyTableView.delegate = nil;
}


#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了");
}

/**
 * Called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
 * 松手时已经静止, 只会调用scrollViewDidEndDragging
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.xsyTableView jp_scrollViewDidEndDraggingWillDecelerate:decelerate];
    [self resetPauseState];
}

/**
 * Called on tableView is static after finger up if the user dragged and tableView is scrolling.
 * 松手时还在运动, 先调用scrollViewDidEndDragging, 再调用scrollViewDidEndDecelerating
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.xsyTableView jp_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.xsyTableView jp_scrollViewDidScroll];
    
}

- (void)resetPauseState{
    self.isSuspend = NO;
    [self.suspendCell.suspendButton setImage:[UIImage new] forState:UIControlStateNormal];
    [self.xsyTableView jp_handleCellUnreachableTypeInVisibleCellsAfterReloadData];
    [self.xsyTableView jp_playVideoInVisibleCellsIfNeed];
}


#pragma mark - JPScrollViewPlayVideoDelegate

- (void)scrollView:(UIScrollView<JPVideoPlayerScrollViewProtocol> *)scrollView
willPlayVideoOnCell:(UIView<JPVideoPlayerCellProtocol>  *)cell {
    
    
    [cell.jp_videoPlayView jp_resumeMutePlayWithURL:cell.jp_videoURL
                                 bufferingIndicator:nil
                                       progressView:[SYVideoPlayerProgressView new]
                                      configuration:^(UIView * _Nonnull view, JPVideoPlayerModel * _Nonnull playerModel) {
        
        playerModel.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.jp_muted = self.muteOpen;
        if (self.isSuspend) {
            [view.jp_videoPlayerView jp_pause];
            
        }else{
            [view.jp_videoPlayerView jp_resume];
        }
    }];
}


#pragma mark - PTSSYHomeHotMainCellDelegate
- (void)suspendDidClickCell:(PTSSYHomeHotMainCell *)cell{
    
    
    if (self.suspendCell.indexPath != cell.indexPath && self.isSuspend) {
        return;
    }
    
    self.suspendCell = cell;
    
    if (self.isSuspend) {
        
        self.isSuspend = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.suspendCell.suspendButton setImage:[UIImage new] forState:UIControlStateNormal];
        });
    }else{
        
        self.isSuspend = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.suspendCell.suspendButton setImage:[UIImage imageNamed:@"bound"] forState:UIControlStateNormal];
        });
    }
    
    [self.xsyTableView reloadData];
    [self.xsyTableView jp_handleCellUnreachableTypeInVisibleCellsAfterReloadData];
    [self.xsyTableView jp_playVideoInVisibleCellsIfNeed];
}


- (void)autoPlayer {
    
}

- (void)pause {
    
}

- (void)resume {
    
}

@end
