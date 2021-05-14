//
//  SYDrawingBoardColorView.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/12.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SYDrawingBoardColorViewDelegate <NSObject>

- (void)drawingBoardColor:(UIColor *)color;

@end

@interface SYDrawingBoardColorView : UIView

@property (nonatomic, weak)id <SYDrawingBoardColorViewDelegate>delegate;

- (void)showOnWindow;

- (void)hiddenOnWindow;

@end

NS_ASSUME_NONNULL_END
