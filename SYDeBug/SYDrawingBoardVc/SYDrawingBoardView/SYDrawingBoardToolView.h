//
//  SYDrawingBoardToolView.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/12.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SYDrawingBoardToolViewDelegate <NSObject>

- (void)didToolBtn:(NSIndexPath*)indexPath;
- (void)lineWidth:(CGFloat)lineWidth;

@end

@interface SYDrawingBoardToolView : UIView

@property (nonatomic, strong)UISlider *slider;
@property (nonatomic, weak)id <SYDrawingBoardToolViewDelegate>delegate;

@end


@interface SYDrawingBoardToolItemCell : UICollectionViewCell

@property (nonatomic, strong)UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
