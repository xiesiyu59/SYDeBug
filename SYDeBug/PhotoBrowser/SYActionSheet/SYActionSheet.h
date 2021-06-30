//
//  SYActionSheet.h
//  Footstone
//
//  Created by xiesiyu on 2020/8/26.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYActionSheet : UIView

/**
 底部选择弹框

 @param title 提示语，显示在顶部，可为空
 @param options 由选项的标题组成的数组
 @param selectedBlock 点击后选项的索引
 @param cancelTitle 底部取消按钮的样式
 @param cancelBlock 取消的事件
 */
+ (void)showWithTitle:(NSString *_Nullable)title
              options:(NSArray <NSString *>*)options
        selectedBlock:(void(^)(NSInteger selectedIndex))selectedBlock
          cancelTitle:(NSString *)cancelTitle
          cancelBlock:(void(^)(void))cancelBlock;


/**
 图片底部选择弹框

 @param title 提示语，显示在顶部，可为空
 @param options 由选项的标题组成的数组
 @param selectedBlock 点击后选项的索引
 @param cancelTitle 底部取消按钮的样式
 @param cancelBlock 取消的事件
 */
+ (void)showWithTitle:(NSString *_Nullable)title
              options:(NSArray <NSString *>*)options
         imageOptions:(NSArray <NSString *>*)imageOptions
        selectedBlock:(void(^)(NSInteger selectedIndex))selectedBlock
          cancelTitle:(NSString *)cancelTitle
          cancelBlock:(void(^)(void))cancelBlock;

@end

NS_ASSUME_NONNULL_END
