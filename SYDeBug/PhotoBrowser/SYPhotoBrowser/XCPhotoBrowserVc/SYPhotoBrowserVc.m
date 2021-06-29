//
//  SYPhotoBrowserVc.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/6/29.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYPhotoBrowserVc.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "UIView+Screenshot.h"
#import "SYPhotoCell.h"


@interface SYPhotoBrowserVc () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SYPhotoCellDelegate>

@property (nonatomic, strong) NSMutableArray<SYPhotoModel *> *dataSource;
@property (nonatomic, strong) NSMutableArray<NSString *> *uuidArr;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) BOOL statusBarShouldBeHidden;

@property (nonatomic, assign) BOOL statusBarShouldBeRefresh;

@property (nonatomic, strong) UIImageView *transitionImageView;

@property (nonatomic, strong) UIImageView *screenImageView;

@end


@implementation SYPhotoBrowserVc {
    CGAffineTransform transform;
    CGFloat animationDuration;
    CGRect originFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubviews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //如果是POP回来的，需刷新状态栏
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //如果是PUSH走的，需要做以下操作
    self.statusBarShouldBeHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //如果是POP回来的，需刷新状态栏
    if (self.statusBarShouldBeHidden == NO) {
        self.statusBarShouldBeHidden = YES;
        [UIView animateWithDuration:animationDuration animations:^(void) {
            [self setNeedsStatusBarAppearanceUpdate];
        } completion:^(BOOL finished) {}];
    }
}

#pragma mark - Intial Methods
- (void)initSubviews {
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopDisabled = YES;
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    self.screenImageView = [[UIImageView alloc]initWithFrame:screenRect];
    self.screenImageView.image = _screenImage;
    [self.view addSubview:_screenImageView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:screenRect collectionViewLayout:layout];
    
    _collectionView.showsVerticalScrollIndicator = 0;
    _collectionView.showsHorizontalScrollIndicator = 0;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = 1;
//    _collectionView.
    
    [_collectionView registerClass:[SYPhotoCell class] forCellWithReuseIdentifier:NSStringFromClass([SYPhotoCell class])];
    
    [self configDataSource];
    
    [self.view addSubview:_collectionView];
    self.collectionView.hidden = YES;
    
    if (self.dataSource.count > 1) {
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:self.currentIndex > self.dataSource.count - 1 ? self.dataSource.count - 1 : self.currentIndex inSection:0];
        
        [_collectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    
    
    //过渡动画
    
//    self.statusBarShouldBeHidden = YES;
    animationDuration = .25;
    
//    [UIView animateWithDuration:animationDuration animations:^(void) {
//        [self setNeedsStatusBarAppearanceUpdate];
//    } completion:^(BOOL finished) {}];
    
    originFrame = [self.imageView.superview convertRect:self.imageView.frame toView:[UIApplication sharedApplication].keyWindow];
    // TODO: Frame
    CGRect targetFrame = {CGPointZero, self.imageView.image.size};
    
    self.transitionImageView = [[UIImageView alloc]initWithImage:self.imageView.image];
    self.transitionImageView.contentMode = self.imageView.contentMode;
    self.transitionImageView.clipsToBounds = YES;
    
    [self.view addSubview:self.transitionImageView];
    
    CGFloat ratio = screenRect.size.width/targetFrame.size.width;
    targetFrame.size.height = targetFrame.size.height*ratio;
    targetFrame.size.width = screenRect.size.width;
    
//    CGFloat sx = originFrame.size.width / targetFrame.size.width;
//    CGFloat sy = originFrame.size.height / targetFrame.size.height;
    
//    CGFloat tx = -(targetFrame.size.width - sx * targetFrame.size.width)/2.f + originFrame.origin.x;
//    CGFloat ty = -(targetFrame.size.height - sy * targetFrame.size.height)/2.f + originFrame.origin.y;
    
    
    
//    transform = CGAffineTransformMakeTranslation(tx, ty);
//    transform = CGAffineTransformScale(transform, sx, sy);
    
//    self.transitionImageView.transform = transform;
    self.transitionImageView.frame = originFrame;
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.screenImageView.alpha = 0;
//        self.transitionImageView.transform = CGAffineTransformIdentity;
        self.transitionImageView.frame = targetFrame;
        self.transitionImageView.center = self.view.center;
        
    } completion:^(BOOL finished) {
        
        self.collectionView.hidden = NO;
        self.transitionImageView.hidden = YES;
        
    }];
    

}



- (UIStatusBarStyle)preferredStatusBarStyle{
    return self.fromViewStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden{
    return self.statusBarShouldBeHidden;
}
#pragma mark - FetchData
- (void)configDataSource{
    
    self.dataSource = [NSMutableArray array];
    self.uuidArr = [NSMutableArray array];
    
    NSInteger index = 0;
    
    switch (self.type) {
        case SYPhotoBrowserTypeImage:{
            for(UIImage *image in self.imageArr){
                SYPhotoModel *model = [[SYPhotoModel alloc] initWithImage:image];
                model.type = SYPhotoBrowserTypeImage;
                if (index == self.currentIndex) {
                    model.thumbImage = image;
                }
                [self.dataSource addObject:model];
                [self.uuidArr addObject:[NSUUID UUID].UUIDString];
                index ++;
            }
            break;
        }
            
        case SYPhotoBrowserTypeUrl:{
            for(NSString *imageUrl in self.imageUrlArr){
                SYPhotoModel *model = [[SYPhotoModel alloc]initWithImageUrl:imageUrl];
                model.type = SYPhotoBrowserTypeUrl;
                if (index == self.currentIndex) {
                    model.thumbImage = self.imageView.image;
                }
                [self.dataSource addObject:model];
                [self.uuidArr addObject:[NSUUID UUID].UUIDString];
                index ++;
            }
            break;
        }
            
            
        default:
            break;
    }
}

- (void)setImageArr:(NSArray<UIImage *> *)imageArr{
    _imageArr = imageArr;
}

#pragma mark - Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.bounds.size;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SYPhotoCell class]) forIndexPath:indexPath];
    cell.photoModel = self.dataSource[indexPath.row];
    cell.uuid = self.uuidArr[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)tapWithPhotoModel:(SYPhotoModel *)photoModel{
    
    self.statusBarShouldBeHidden = NO;
    
    CGPoint pInView = [self.view convertPoint:self.collectionView.center toView:self.collectionView];
    NSIndexPath *indexPathNow = [self.collectionView indexPathForItemAtPoint:pInView];
    
    //　当前索引是不是原来的索引
    BOOL isOriginImageIndex = indexPathNow.row == self.currentIndex;
    
    CGFloat dismissAnimationDuration = .22;
    
    if (isOriginImageIndex) {
        
        
        self.collectionView.hidden = YES;
        self.transitionImageView.hidden = NO;
        self.transitionImageView.clipsToBounds = YES;
        

        [UIView animateWithDuration:dismissAnimationDuration animations:^{
            
            [self setNeedsStatusBarAppearanceUpdate];
            self.screenImageView.alpha = 1;
            self.transitionImageView.frame = self->originFrame;
            if (self.type == SYPhotoBrowserTypeImage) {
                self.transitionImageView.alpha = 0;
            }
            
        } completion:^(BOOL finished) {
            
            [self.navigationController popViewControllerAnimated:NO];
            
        }];
    }else{
        self.screenImageView.alpha = 1;
        self.statusBarShouldBeHidden = NO;
        
        [UIView animateWithDuration:dismissAnimationDuration animations:^{
            
            [self setNeedsStatusBarAppearanceUpdate];
            self.collectionView.alpha = 0;
            self.collectionView.transform = CGAffineTransformMakeScale(.3, .3);
            
        } completion:^(BOOL finished) {
            self.screenImageView.hidden = YES;
            [self.navigationController popViewControllerAnimated:NO];
        }];
    }
    
    

}

- (void)longPressWithPhotoModel:(SYPhotoModel *)photoModel{

    NSMutableArray *titleArr = [NSMutableArray array];
    if (photoModel.hasQrcode) {
            [titleArr addObject:@"识别图中二维码"];
    }
//    [titleArr addObject:@"保存图片到本地"];
//    [YZActionSheet showActionSheetWithTitles:[titleArr copy] selected:^(NSInteger idx) {
//        if (idx == titleArr.count - 1) {
//            if (![[PrivacyPermissionManager sharedManager]hasBeenBannedForPhotoLibraryPermission]){
//                    UIImageWriteToSavedPhotosAlbum(photoModel.originImage ? photoModel.originImage : photoModel.thumbImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//            }
//
//        }else{
//            [self qrcodeHandleResult:photoModel.qrCode completed:^(RespondModel *respondModel) {
//                if (respondModel.code != 200) {
//                    [PromptViewTwo promptTitle:respondModel.desc];
//                }
//            }];
//        }
//    }];
    
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
//        [PromptViewTwo promptTitle:error.localizedDescription];
    }else{
//        [PromptViewTwo promptTitle:@"保存成功"];
    }
}

- (void)cellPrepareForReuseWithPhotoModel:(SYPhotoModel *)photoModel uuid:(NSString *)uuid{
    [self.dataSource replaceObjectAtIndex:[self.uuidArr indexOfObject:uuid] withObject:photoModel];
}

- (instancetype)initWithDataSource:(NSArray *)dataSource
                      currentIndex:(NSInteger)currentIndex
                         imageView:(UIImageView *)imageView
                              type:(SYPhotoBrowserType)type
                       screenImage:(UIImage *)screenImage
            fromViewStatusBarStyle:(UIStatusBarStyle)fromViewStatusBarStyle{
    if (self = [super init]) {
        
        switch (type) {
            case SYPhotoBrowserTypeImage:
                self.imageArr = dataSource;
                break;
                
            case SYPhotoBrowserTypeUrl:
                self.imageUrlArr = dataSource;
                break;
                
            default:
                break;
        }
        
        self.currentIndex = currentIndex;
        self.imageView = imageView;
        self.type = type;
        self.screenImage = screenImage;
        self.fromViewStatusBarStyle = fromViewStatusBarStyle;
        
    }
    return self;
}

+ (void)showWithDataSource:(NSArray *)dataSource
              currentIndex:(NSInteger)currentIndex
                 imageView:(UIImageView *)imageView
                      type:(SYPhotoBrowserType)type
                 currentVc:(UIViewController *)currentVc{
    
    if (dataSource.count == 0) return;
    
    SYPhotoBrowserVc *browser = [[SYPhotoBrowserVc alloc]initWithDataSource:dataSource
                                                           currentIndex:currentIndex
                                                              imageView:imageView
                                                                   type:type
                                                            screenImage:[[UIApplication sharedApplication].keyWindow imageByRenderingView]
                                                 fromViewStatusBarStyle:[UIApplication sharedApplication].statusBarStyle];

    [currentVc.navigationController pushViewController:browser animated:NO];
    
}


#pragma mark - Target Methods

@end
