//
//  SYTreeViewCell.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/3/29.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RATreeView.h>
#import "RaTreeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYTreeViewCell : UITableViewCell

@property (nonatomic, strong)UIView *iconView;
@property (nonatomic, strong)UILabel *titleLabel;

- (void)syTreeViewCellWithModel:(RaTreeModel *)model level:(NSInteger)level children:(NSInteger )children;

+ (instancetype)treeViewCellWith:(RATreeView *)treeView;

@end

NS_ASSUME_NONNULL_END
