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


@interface SYCountDownButton : UIButton {
    
    NSInteger _second;
    dispatch_source_t _timer;
    
    touchedDownBlock _touchedDownBlock;
    didChangeBlock _didChangeBlock;
    didFinishedBlock _didFinishedBlock;
    
}

@property (nonatomic, strong)NSString *cacheName;   //保存倒计时

- (void)addToucheHandler:(touchedDownBlock)touchHandler;
- (void)startWithSecond:(NSInteger)second;

- (void)didChange:(didChangeBlock)didChangeBlock;
- (void)didFinished:(didFinishedBlock)didFinishedBlock;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
