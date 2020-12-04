//
//  SystemPhotoViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/11/27.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SystemPhotoViewController.h"
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import "GridViewCell.h"
#import "SystemPhotoDetailViewController.h"

@interface SystemPhotoViewController () <UICollectionViewDelegate, UICollectionViewDataSource>{
    CGSize thumbnailSize;
    CGRect previousPreheatRect;
}

@property (nonatomic, strong) PHFetchResult<PHAsset *> *fetchResult;
@property (nonatomic, strong) PHAssetCollection *assetCollection;
@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property (nonatomic, strong) PHImageRequestOptions *requestOption;

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation SystemPhotoViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat scale = UIScreen.mainScreen.scale;
    CGFloat item_WH = floor((kScreenWidth-32-10-10)/3);
    thumbnailSize = CGSizeMake(item_WH * scale, item_WH * scale);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateCachedAssets];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"相册照片";
    //每次访问相册都会调用这个handler  检查改app的授权情况
    //PHPhotoLibrary
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            //code
        }
    }];
    
    [self initWithInitialization];
    [self initWithinitializationDataSource];
}

#pragma mark - <初始化数据源>
- (void)initWithinitializationDataSource {
    
    if (!_fetchResult) {
        PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
        allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        _fetchResult = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    }
    
    _imageManager = [[PHCachingImageManager alloc] init];
    
    _requestOption = [[PHImageRequestOptions alloc] init];
    // 若设置 PHImageRequestOptionsResizeModeExact 则 requestImageForAsset 下来的图片大小是 targetSize 的
    _requestOption.resizeMode = PHImageRequestOptionsResizeModeNone;
    _requestOption.synchronous = YES;
    _requestOption.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    // 若 _requestOption = nil，则承载图片的 UIImageView 需要添加如下代码
    /*
     _imageView.contentMode = UIViewContentModeScaleAspectFill;
     _imageView.clipsToBounds = YES;
     */
//    _requestOption = nil;
    
    [self resetCachedAssets];
}

- (void)resetCachedAssets
{
    [_imageManager stopCachingImagesForAllAssets];
    previousPreheatRect = CGRectZero;
}

- (void)updateCachedAssets
{
    if (!self.isViewLoaded || self.view.window == nil) {
        return;
    }
    
    // 预热区域 preheatRect 是 可见区域 visibleRect 的两倍高
    CGRect visibleRect = CGRectMake(0.f, self.collectionView.contentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    CGRect preheatRect = CGRectInset(visibleRect, 0, -0.5*visibleRect.size.height);
    
    // 只有当可见区域与最后一个预热区域显著不同时才更新
    CGFloat delta = fabs(CGRectGetMidY(preheatRect) - CGRectGetMidY(previousPreheatRect));
    if (delta > self.view.bounds.size.height / 3.f) {
        // 计算开始缓存和停止缓存的区域
        [self computeDifferenceBetweenRect:previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
            [self imageManagerStopCachingImagesWithRect:removedRect];
        } addedHandler:^(CGRect addedRect) {
            [self imageManagerStartCachingImagesWithRect:addedRect];
        }];
        previousPreheatRect = preheatRect;
    }
}

- (void)computeDifferenceBetweenRect:(CGRect)oldRect andRect:(CGRect)newRect removedHandler:(void (^)(CGRect removedRect))removedHandler addedHandler:(void (^)(CGRect addedRect))addedHandler
{
    if (CGRectIntersectsRect(newRect, oldRect)) {
        CGFloat oldMaxY = CGRectGetMaxY(oldRect);
        CGFloat oldMinY = CGRectGetMinY(oldRect);
        CGFloat newMaxY = CGRectGetMaxY(newRect);
        CGFloat newMinY = CGRectGetMinY(newRect);
        //添加 向下滑动时 newRect 除去与 oldRect 相交部分的区域（即：屏幕外底部的预热区域）
        if (newMaxY > oldMaxY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));
            addedHandler(rectToAdd);
        }
        //添加 向上滑动时 newRect 除去与 oldRect 相交部分的区域（即：屏幕外底部的预热区域）
        if (oldMinY > newMinY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));
            addedHandler(rectToAdd);
        }
        //移除 向上滑动时 oldRect 除去与 newRect 相交部分的区域（即：屏幕外底部的预热区域）
        if (newMaxY < oldMaxY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));
            removedHandler(rectToRemove);
        }
        //移除 向下滑动时 oldRect 除去与 newRect 相交部分的区域（即：屏幕外顶部的预热区域）
        if (oldMinY < newMinY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));
            removedHandler(rectToRemove);
        }
    }
    else {
        //当 oldRect 与 newRect 没有相交区域时
        addedHandler(newRect);
        removedHandler(oldRect);
    }
}

- (void)imageManagerStartCachingImagesWithRect:(CGRect)rect
{
    NSMutableArray<PHAsset *> *addAssets = [self indexPathsForElementsWithRect:rect];
    [_imageManager startCachingImagesForAssets:addAssets targetSize:thumbnailSize contentMode:PHImageContentModeAspectFill options:_requestOption];
}

- (void)imageManagerStopCachingImagesWithRect:(CGRect)rect
{
    NSMutableArray<PHAsset *> *removeAssets = [self indexPathsForElementsWithRect:rect];
    [_imageManager stopCachingImagesForAssets:removeAssets targetSize:thumbnailSize contentMode:PHImageContentModeAspectFill options:_requestOption];
}

- (NSMutableArray<PHAsset *> *)indexPathsForElementsWithRect:(CGRect)rect
{
    UICollectionViewLayout *layout = self.collectionView.collectionViewLayout;
    NSArray<__kindof UICollectionViewLayoutAttributes *> *layoutAttributes = [layout layoutAttributesForElementsInRect:rect];
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    for (__kindof UICollectionViewLayoutAttributes *layoutAttr in layoutAttributes) {
        NSIndexPath *indexPath = layoutAttr.indexPath;
        PHAsset *asset = [_fetchResult objectAtIndex:indexPath.item];
        [assets addObject:asset];
    }
    return assets;
}

#pragma mark - UIScrollViewDelegate -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateCachedAssets];
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[GridViewCell class] forCellWithReuseIdentifier:GridViewCell.className];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _fetchResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GridViewCell.className forIndexPath:indexPath];
    PHAsset *asset = [_fetchResult objectAtIndex:indexPath.item];
    // 给 Live Photo 添加一个标记
    if (@available(iOS 9.1, *)) {
        if (asset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) {
            cell.livePhotoBadgeImage = [PHLivePhotoView livePhotoBadgeImageWithOptions:PHLivePhotoBadgeOptionsOverContent];
        }
    }
    
    cell.representedAssetIdentifier = asset.localIdentifier;
    // targetSize 是以像素计量的，所以需要实际的 size * UIScreen.mainScreen.scale
    [_imageManager requestImageForAsset:asset targetSize:thumbnailSize contentMode:PHImageContentModeAspectFill options:_requestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        // 当 resultHandler 被调用时，cell可能已被回收，所以此处加个判断条件
        if ([cell.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
            cell.thumbnailImage = result;
        }
    }];
    return cell;
}

#pragma mark -UICollectionViewDelegateFlowLayout
//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = floor((kScreenWidth-32-10-10)/3);
    return CGSizeMake(width, width);
}

//间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 16, 0, 16);
}
//横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
//纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PHAsset *asset = [_fetchResult objectAtIndex:indexPath.item];
    [_imageManager requestImageForAsset:asset targetSize:thumbnailSize contentMode:PHImageContentModeAspectFill options:_requestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        // 当 resultHandler 被调用时，cell可能已被回收，所以此处加个判断条件
        NSLog(@"%@--%@",result,info);
        SystemPhotoDetailViewController *vc = [[SystemPhotoDetailViewController alloc] init];
        vc.photoImage = result;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (void)dealloc{
    NSLog(@"dealloc");
}

@end
