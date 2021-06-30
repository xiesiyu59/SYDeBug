//
//  SYPhotoCell.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/6/29.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYPhotoCell.h"
#import <UIView+WebCache.h>
#import <SDWebImageIndicator.h>
#import "SYToast.h"

#define PhotoCellMaxScale 2.0
#define PhotoCellMinScale 0.8

@interface SYPhotoCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic,strong) UIScrollView *scrollView;

/** 获取原图的按钮 */
@property (nonatomic, strong) UIButton *originButton;

@end

@implementation SYPhotoCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapAction:)];
        doubleTap.numberOfTapsRequired = 2;
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        
        [tap requireGestureRecognizerToFail:longPress];
        [tap requireGestureRecognizerToFail:doubleTap];
        
        self.contentView.userInteractionEnabled = YES;
        [self.contentView addGestureRecognizer:tap];
        [self.contentView addGestureRecognizer:doubleTap];
        [self.contentView addGestureRecognizer:longPress];
        
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    return self;
}



- (void)initSubviews {
    
    self.imageView = [[UIImageView alloc]init];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self.contentView addSubview:self.originButton];
    

}


- (void)dealloc{
    
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.maximumZoomScale = PhotoCellMaxScale;
        _scrollView.minimumZoomScale = PhotoCellMinScale;
        _scrollView.showsVerticalScrollIndicator = 0;
        _scrollView.showsHorizontalScrollIndicator = 0;
        _scrollView.zoomScale = 1;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIButton *)originButton{
    if (!_originButton) {
        _originButton = [[UIButton alloc]init];
        [_originButton setTitle:@"点击查看大图" forState:UIControlStateNormal];
        [_originButton setTitle:@"加载中..." forState:UIControlStateSelected];
        _originButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _originButton.backgroundColor = kColorWithRGBA(153, 153, 153, .5);
        _originButton.layer.cornerRadius = 16;
        _originButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _originButton.layer.masksToBounds = 1;
        [_originButton sizeToFit];
        CGRect rect = _originButton.frame;
        rect.size.width += 24;
        rect.size.height = 32;
        
        _originButton.hidden = YES;
        
        _originButton.frame = rect;
        _originButton.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds) - 44);
        [_originButton addTarget:self action:@selector(getOriginImageAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _originButton;
}

- (void)setPhotoModel:(SYPhotoModel *)photoModel{
    _photoModel = photoModel;
    
    //初始化状态
    _photoModel.modelUpdate = NO;
    
    if (self.photoModel.originImage != nil) {
        self.imageView.image = self.photoModel.originImage;
        [self adjustFrame];
        self.originButton.hidden = YES;
    }else{

        if ([AFNetworkReachabilityManager sharedManager].isReachableViaWiFi) {
            
            //是WI-FI，尝试去加载原图
            [[SDImageCache sharedImageCache] diskImageExistsWithKey:self.photoModel.originImageUrl.absoluteString completion:^(BOOL isInCache) {
                if (isInCache) {
                    UIImage *image = [[SDImageCache sharedImageCache]imageFromCacheForKey:self.photoModel.originImageUrl.absoluteString];
                    if (image) {
                        self.photoModel.originImage = image;
                    }
                }
                [self getOriginImageAction:nil];
            }];

        }else{
            //不是WI-FI
            if (self.photoModel.thumbImage != nil) {
                //有缩略图片
                [[SDImageCache sharedImageCache] diskImageExistsWithKey:self.photoModel.originImageUrl.absoluteString completion:^(BOOL isInCache) {
                    if (isInCache) {
                        //有高清缓存
                        UIImage *image = [[SDImageCache sharedImageCache]imageFromCacheForKey:self.photoModel.originImageUrl.absoluteString];
                        if (image) {
                            self.photoModel.originImage = image;
                            self.imageView.image = image;
                            [self adjustFrame];
                            self.originButton.hidden = YES;
                        }else{
                            
                            self.imageView.image = self.photoModel.thumbImage;
                            [self adjustFrame];
                            if (photoModel.type == SYPhotoBrowserTypeImage) {
                                self.originButton.hidden = YES;
                            }else{
                                self.originButton.hidden = NO;
                            }
                        }
                        
                    }else{
                        //没有高清缓存
                        self.imageView.image = self.photoModel.thumbImage;
                        [self adjustFrame];
                        if (photoModel.type == SYPhotoBrowserTypeImage) {
                            self.originButton.hidden = YES;
                        }else{
                            self.originButton.hidden = NO;
                        }
                    }
                }];
                
            }else{
                
                [[SDImageCache sharedImageCache] diskImageExistsWithKey:self.photoModel.originImageUrl.absoluteString completion:^(BOOL isInCache) {
                    if (isInCache) {
                        //有高清缓存
                        UIImage *image = [[SDImageCache sharedImageCache]imageFromCacheForKey:self.photoModel.originImageUrl.absoluteString];
                        if (image) {
                            self.photoModel.originImage = image;
                            self.imageView.image = image;
                            [self adjustFrame];
                            self.originButton.hidden = YES;
                        }else{
                            
                            self.imageView.image = self.photoModel.thumbImage;
                            [self adjustFrame];
                            if (photoModel.type == SYPhotoBrowserTypeImage) {
                                self.originButton.hidden = YES;
                            }else{
                                self.originButton.hidden = NO;
                            }
                        }
                    }else{
                        
                        //没有缩略图,加载缩略图
                        [self.imageView sd_setImageWithURL:self.photoModel.thumbImageUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                            if (error) {
                                //出错，尝试加载原图
                                [self getOriginImageAction:nil];
                            }else{
                                //成功，更新Model，计算尺寸
                                self.photoModel.thumbImage = image;
                                [self adjustFrame];
                                if (photoModel.type == SYPhotoBrowserTypeImage) {
                                    self.originButton.hidden = YES;
                                }else{
                                    self.originButton.hidden = NO;
                                }
                            }
                        }];
                        
                    }
                }];
            }
            
        }
        
    }
    
}

- (void)getOriginImageAction:(UIButton *)button{
    
    //加载原图，有缩略图就用缩略图作为占位图
    
    self.originButton.hidden = YES;
    
    if (self.photoModel.thumbImage == nil) {
        self.imageView.frame = [UIScreen mainScreen].bounds;
    }else{
        
        self.imageView.image = self.photoModel.thumbImage;
        [self adjustFrame];
    }
    
    [self.imageView sd_setImageWithURL:self.photoModel.originImageUrl placeholderImage:self.photoModel.thumbImage ?: nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (error) {
            //错误
            if (self.photoModel.thumbImage == nil) {
                
                //没有缩略图，没有原图，提示错误
                [SYToast showWithMessage:[NSString stringWithFormat:@"获取原图失败%ld",(long)error.code]];
                if (self.photoModel.type == SYPhotoBrowserTypeImage) {
                    self.originButton.hidden = YES;
                }else{
                    self.originButton.hidden = NO;
                }
            }else{
                
                //有缩略图，没有原图
                if (button == nil) {
                    
                    //不是点击事件，Do nothing
                    if (self.photoModel.type == SYPhotoBrowserTypeImage) {
                        self.originButton.hidden = YES;
                    }else{
                        self.originButton.hidden = NO;
                    }
                }else{
                    
                    //是点击事件，提示
                    [SYToast showWithMessage:[NSString stringWithFormat:@"获取原图失败%ld",(long)error.code]];
                    if (self.photoModel.type == SYPhotoBrowserTypeImage) {
                        self.originButton.hidden = YES;
                    }else{
                        self.originButton.hidden = NO;
                    }
                }
            }
            
        }else{
            //成功
            self.photoModel.originImage = image;
            [self updateCache];
            [self adjustFrame];
        }
    }];
    
}


/**
 更新缩略图缓存
 */
- (void)updateCache{
    [[SDWebImageManager sharedManager] cacheKeyForURL:self.photoModel.originImageUrl];
}

#pragma mark - 图片处理
- (void)adjustFrame{
    
    [self.imageView sizeToFit];
    
    CGRect frame = self.scrollView.frame;
    
    if (self.imageView.image) {
        CGSize imageSize = self.imageView.image.size;
        if (imageSize.height == 0 || imageSize.width == 0) {
            return;
        }
        CGRect imageFrame = {CGPointZero,imageSize};
        
        CGFloat ratio = frame.size.width/imageFrame.size.width;
        imageFrame.size.height = imageFrame.size.height*ratio;
        imageFrame.size.width = frame.size.width;
        
        
        
        self.imageView.frame = imageFrame;
        self.scrollView.contentSize = imageFrame.size;
        self.imageView.center = [self centerOfScrollViewContent:self.scrollView];
        
        CGFloat maxScale = frame.size.height/imageFrame.size.height;
        maxScale = frame.size.width/imageFrame.size.width>maxScale?frame.size.width/imageFrame.size.width:maxScale;
        //        CGFloat maxScale = MAX(frame.size.height/imageFrame.size.height,
        //                               frame.size.width/imageFrame.size.width);
        
        maxScale = maxScale>PhotoCellMaxScale?maxScale:PhotoCellMaxScale;
        self.scrollView.minimumZoomScale = PhotoCellMinScale;
        self.scrollView.maximumZoomScale = maxScale;
        self.scrollView.zoomScale = 1.0f;
        
        
    }else{
        frame.origin = CGPointZero;
        self.imageView.frame = frame;
        self.scrollView.contentSize = self.imageView.frame.size;
    }
    self.scrollView.contentOffset = CGPointZero;
    
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView{
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    UIView *subView = self.imageView;
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)resetScale{
    if (self.scrollView.zoomScale > 1.0) {
        self.scrollView.zoomScale = 1.0;
    }
}

#pragma mark - 点击事件
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(longPressWithPhotoModel:)]) {
            [self.delegate longPressWithPhotoModel:self.photoModel];
        }
    }

}

- (void)doubleTapAction:(UITapGestureRecognizer *)doubleTap{
    
    if (!self.photoModel.thumbImage)return;
    
    CGPoint touchPoint = [doubleTap locationInView:self];
    if (self.scrollView.zoomScale <= 1.0) {
        CGFloat scaleX = touchPoint.x + self.scrollView.contentOffset.x;
        CGFloat sacleY = touchPoint.y + self.scrollView.contentOffset.y;
        [self.scrollView zoomToRect:CGRectMake(scaleX, sacleY, 10, 10) animated:YES];
    } else {
        [self.scrollView setZoomScale:1.0 animated:YES];
    }
}

- (void)tapAction{
    if (self.scrollView.zoomScale != 1.0) {
        [self.scrollView setZoomScale:1.0 animated:YES];
    }else{
        if ([self.delegate respondsToSelector:@selector(tapWithPhotoModel:)]) {
            [self.delegate tapWithPhotoModel:self.photoModel];
        }
    }
}



/**
 将被复用的时候，如果Model 被更新过，回传给Controller
 */
- (void)prepareForReuse{
    [super prepareForReuse];
    if (!self.photoModel.modelUpdate) return;
    
    if ([self.delegate respondsToSelector:@selector(cellPrepareForReuseWithPhotoModel:uuid:)]) {
        [self.delegate cellPrepareForReuseWithPhotoModel:self.photoModel uuid:self.uuid];
    }
}






@end
