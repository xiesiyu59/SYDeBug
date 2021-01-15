//
//  SYCountDownButton.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/1/15.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SYCountDownButton;

typedef void (^touchedDownBlock)(SYCountDownButton *countDownButton,NSInteger tag);
typedef void (^didChangeBlock)(SYCountDownButton *countDownButton,NSInteger second);
typedef void (^didFinishedBlock)(SYCountDownButton *countDownButton);

/// 倒计时按钮,本地化轻量保存计时。如有需要退出界面删除，在viewDidDisappear:(BOOL)animated 调用stop方法
@interface SYCountDownButton : UIButton {
    
    NSInteger _second;
    dispatch_source_t _timer;
    
    touchedDownBlock _touchedDownBlock;
    didChangeBlock _didChangeBlock;
    didFinishedBlock _didFinishedBlock;
}

@property (nonatomic, strong)NSString *cacheName;   //保存倒计时

///开始倒计时
- (void)startWithSecond:(NSInteger)second;
- (void)addToucheHandler:(touchedDownBlock)touchHandler;
- (void)didChange:(didChangeBlock)didChangeBlock;
- (void)didFinished:(didFinishedBlock)didFinishedBlock;
///停止倒计时，移除本地保存计时时间
- (void)stop;

@end

NS_ASSUME_NONNULL_END
