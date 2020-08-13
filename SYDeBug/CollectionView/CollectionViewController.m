//
//  CollectionViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/8/11.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "CollectionViewController.h"
#import "XCPhotoBrowser.h"

@interface CollectionViewController ()  <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation CollectionViewController

- (NSArray*)imageArray{
    if (!_imageArray) {
        _imageArray = [NSArray array];
    }
    return _imageArray;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithinitializationDataSource];
    [self initWithInitialization];
}

#pragma mark - <初始化数据源>
- (void)initWithinitializationDataSource {
    self.imageArray= @[@"http://cdn.gaosainet.com/uploads/img/20200602/fb6628722edd42a4f9a01fe0bce51718.jpg",
                       @"http://cdn.gaosainet.com/uploads/img/20200602/38526e0920189c5e4ac5323f77ffd09c.jpg",
                       @"http://cdn.gaosainet.com/uploads/img/20200602/e44651f4142b13d6ebe53d73ee723228.jpg",
                       @"http://cdn.gaosainet.com/uploads/img/20200602/c7e0c77a8f66366a8c6a3345f62d154a.jpg",
                       @"http://cdn.gaosainet.com/uploads/img/20200602/d93ede141c68f12327a894f749eb05b6.jpg",
                       @"http://cdn.gaosainet.com/uploads/img/20200602/cc1d1a538165520eb5321f6d8a383918.jpg",
                       @"http://cdn.gaosainet.com/uploads/img/20200513/4bf1233acb278be65a1f1cbbc855cbd7.jpg",
                       @"http://cdn.gaosainet.com/uploads/img/20200514/4e4383a55cd9ae89efd0640f6d7dba08.jpg",
                       @"http://www.17qq.com/img_biaoqing/68341470.jpeg",
    ];
    
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:UICollectionViewCell.className];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-40);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width);
    }];
    
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UICollectionViewCell.className forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageView sd_setImageWithURL:UrlWithString(self.imageArray[indexPath.row])];
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    
    
    return cell;
}

#pragma mark -UICollectionViewDelegateFlowLayout
//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = floor((kScreenWidth-2)/3);
    return CGSizeMake(width, width);
}

//间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
//横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageView sd_setImageWithURL:UrlWithString(self.imageArray[indexPath.row])];
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    [XCPhotoBrowser showWithDataSource:self.imageArray currentIndex:indexPath.row imageView:imageView currentVc:self];
    
}


@end
