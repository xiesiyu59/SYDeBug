//
//  FileDownloadVc.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/9.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "FileDownloadVc.h"
#import "SYDownloaderManger.h"
#import <SDWebImage/SDWebImage.h>
#import "FileDownloadCell.h"
#import "XCPhotoBrowser.h"
#import "UIView+SYView.h"


static NSString *identifier = @"cell";

@interface FileDownloadVc () <UITableViewDelegate, UITableViewDataSource,FileDownloadCellDelegate>

@property (nonatomic, strong)UITableView *xsyTableView;
@property(nonatomic,strong) NSURL *url;

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *sourceArray;


@end

@implementation FileDownloadVc

#pragma mark - <初始化数据源>


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
    [self initWithInitialization];
    [self initWithinitializationDataSource];
    
}

- (void)initWithinitializationDataSource {
    self.sourceArray = @[@"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200602\/9329134a9d8b1c9f1c51a00456032c5a.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200602\/4952ec89930d47784d7210a76f1f98d7.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200602\/a333028c97d32646ff956211f79f03de.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200602\/4ec64aef15ceb8ddd9d39c4b743b0921.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200602\/17ac9464d618ac5d157aa250c2693d19.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200602\/2b372779c00e8c17de2f152dde75e77d.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200513\/af15fa6fdfe2bb5925367095519e56ca.mp4",
                         @"http:\/\/cdn.gaosainet.com\/uploads\/video\/20200514\/7064afb0814e861bddbf88a0a4f739b4.mp4",
                         @"",
                         
    ];
    
    self.imageArray= @[@"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200602\/fb6628722edd42a4f9a01fe0bce51718.jpg",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200602\/38526e0920189c5e4ac5323f77ffd09c.jpg",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200602\/e44651f4142b13d6ebe53d73ee723228.jpg",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200602\/c7e0c77a8f66366a8c6a3345f62d154a.jpg",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200602\/d93ede141c68f12327a894f749eb05b6.jpg",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200602\/cc1d1a538165520eb5321f6d8a383918.jpg",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200513\/4bf1233acb278be65a1f1cbbc855cbd7.jpg",
                       @"http:\/\/cdn.gaosainet.com\/uploads\/img\/20200514\/4e4383a55cd9ae89efd0640f6d7dba08.jpg",
                       @"http://www.17qq.com/img_biaoqing/68341470.jpeg",
    ];
    
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    self.xsyTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.xsyTableView.delegate = self;
    self.xsyTableView.dataSource = self;
    
    self.xsyTableView.tableFooterView = [UIView new];
    [self.xsyTableView registerClass:[FileDownloadCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.xsyTableView];
    [self.xsyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -- <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.imageArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FileDownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    
    [cell.fileImageView sd_setImageWithURL:UrlWithString(self.imageArray[indexPath.row])];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FileDownloadCell *cell = (FileDownloadCell *)[tableView cellForRowAtIndexPath:indexPath];
    [XCPhotoBrowser showWithDataSource:self.imageArray currentIndex:indexPath.row imageView:cell.fileImageView currentVc:self];
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

- (void)buttonClickType:(LoadType)type didCell:(FileDownloadCell *)cell{
        
    cell.downloadButton.isDownlod = !cell.downloadButton.isDownlod;
    
    NSURL *loadUrl = [NSURL URLWithString:self.sourceArray[cell.indexPath.row]];
    if (type == LoadTypeStart) {
        
        [[SYDownloaderManger shareDownloaderManger] sy_downloadWithUrl:loadUrl withDownProgress:^(float progress) {
            // 下载进度
            NSLog(@"下载进度= %f",progress);
            NSOperationQueue* mainQueue = [NSOperationQueue mainQueue];
            [mainQueue addOperationWithBlock:^{
                // 下载进度
                cell.downloadButton.present = 100*progress;
            }];
            
        } completion:^(NSString * _Nonnull downFilePath) {
            // 下载成功
            NSLog(@"下载成功的路径= %@",downFilePath);
        } fail:^(NSString * _Nonnull error) {
            // 下载出错
            NSLog(@"下载出错的信息= %@",error);
        }];
        
    }else if (type == LoadTypeSuspend){
        [[SYDownloaderManger shareDownloaderManger]pauseloadWithUrl:loadUrl];
    }else if (type == LoadTypeContinue){
        
    }
}

@end
