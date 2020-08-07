//
//  PTSSYHomeHotMainCell.h
//  PetStore
//
//  Created by xiesiyu on 2020/6/3.
//  Copyright © 2020 Petstore. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTSSYHomeHotMainCell;

NS_ASSUME_NONNULL_BEGIN

@protocol PTSSYHomeHotMainCellDelegate <NSObject>

- (void)suspendDidClickCell:(PTSSYHomeHotMainCell *)cell;

@end

@interface PTSSYHomeHotMainCell : UITableViewCell

@property (nonatomic, strong)UIImageView *videoPlayView;
@property(nonatomic, strong)NSIndexPath *indexPath;


@property (nonatomic, strong)UIButton *muteButton;  //声音
@property (nonatomic, copy)void(^muteBlock)(BOOL isOpen);

@property (nonatomic, strong)UIButton *suspendButton;    //暂停播放
@property (nonatomic,weak)id <PTSSYHomeHotMainCellDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
