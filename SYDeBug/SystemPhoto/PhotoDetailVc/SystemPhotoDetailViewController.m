//
//  SystemPhotoDetailViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/11/27.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SystemPhotoDetailViewController.h"
#import "SystemPhotoDetailCell.h"

@interface SystemPhotoDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation SystemPhotoDetailViewController

- (BOOL)sy_preferredNavigationBarHidden{
    return YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.collectionView registerClass:[SystemPhotoDetailCell class] forCellWithReuseIdentifier:SystemPhotoDetailCell.className];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SystemPhotoDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SystemPhotoDetailCell.className forIndexPath:indexPath];
    [cell.lookImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:self.imageArray[indexPath.row]];
    return cell;
}



#pragma mark -UICollectionViewDelegateFlowLayout
//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(kScreenWidth, kScreenHeight);
}

//间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//横向间距-上下
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFLOAT_MIN;
}
//纵向间距-左右
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
