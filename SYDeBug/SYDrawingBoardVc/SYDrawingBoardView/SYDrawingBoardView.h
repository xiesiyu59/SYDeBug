//
//  SYDrawingBoardView.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/12.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYDrawingBoardView : UIView

@property(nonatomic,assign) CGFloat lineWidth;//画笔宽度
@property(nonatomic,strong) UIColor *lineColor;//画笔颜色
- (void)clean;//清除画板
- (void)undo;//回退上一步
- (void)redo;//恢复上一步
- (void)eraser;//橡皮擦
- (void)save;//保存到相册

@end

@interface SYDrawingUIBezierPath : UIBezierPath

+ (instancetype)paintPathWithLineWidth:(CGFloat)width
                            startPoint:(CGPoint)startP;

@end

NS_ASSUME_NONNULL_END
