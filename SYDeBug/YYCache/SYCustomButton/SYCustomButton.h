//
//  SYCustomButton.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/24.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 *  按钮中图片的位置
 */

typedef NS_ENUM(NSInteger, SYButtonAlignment){
    
    SYImageLeftTitleRight = 0,
    SYImageTopTitleBottom,
    SYImageBottomTitleTop,
    SYImageRightTitleLeft
    
};

@interface SYCustomButton : UIControl


@property(nonatomic, assign) CGFloat itemSpace;


///多样式设置参数
- (void)setCoustBtnAlignement:(SYButtonAlignment)alignment
                    itemSpace:(CGFloat)itemSpace
                        image:(UIImage *__nullable)image
                        title:(NSString *__nullable)title;

///只含有标题或者图片设置参数
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)UIFont *font;


@end

NS_ASSUME_NONNULL_END
