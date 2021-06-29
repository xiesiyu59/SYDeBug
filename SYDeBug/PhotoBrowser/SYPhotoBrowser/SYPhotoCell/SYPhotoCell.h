//
//  SYPhotoCell.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/6/29.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SYPhotoCellDelegate <NSObject>

@optional
- (void)longPressWithPhotoModel:(SYPhotoModel *)photoModel;

- (void)tapWithPhotoModel:(SYPhotoModel *)photoModel;


/**
 cell将被复用的时候更新数据源（如果cell数据被更新的话）

 @param photoModel 数据
 @param uuid 标识符
 */
- (void)cellPrepareForReuseWithPhotoModel:(SYPhotoModel *)photoModel uuid:(NSString *)uuid;

@end

@interface SYPhotoCell : UICollectionViewCell

@property (nonatomic, strong) SYPhotoModel *photoModel;

@property (nonatomic, weak) id<SYPhotoCellDelegate> delegate;

@property (nonatomic, strong) NSString *uuid;


@end

NS_ASSUME_NONNULL_END
