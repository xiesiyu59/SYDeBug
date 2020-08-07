//
//  FileDownloadCell.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/9.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYDownloadButton.h"


@class FileDownloadCell;

typedef NS_ENUM(NSInteger, LoadType){
    
    LoadTypeStart,
    LoadTypeSuspend,
    LoadTypeContinue,

};


NS_ASSUME_NONNULL_BEGIN

@protocol FileDownloadCellDelegate <NSObject>

- (void)buttonClickType:(LoadType)type didCell:(FileDownloadCell *)cell;

@end


@interface FileDownloadCell : UITableViewCell


@property (nonatomic, strong)UIImageView *fileImageView;

@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic, strong)SYDownloadButton *downloadButton;

@property (nonatomic, weak)id <FileDownloadCellDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
