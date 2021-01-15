//
//  SYCountDownButton.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/1/15.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYCountDownButton.h"
#import "LocalDataTool.h"

@implementation SYCountDownButton

#pragma -mark touche action
-(void)addToucheHandler:(touchedDownBlock)touchHandler{
    _touchedDownBlock = [touchHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touched:(SYCountDownButton*)sender{
    if (_touchedDownBlock) {
        _touchedDownBlock(sender,sender.tag);
    }
}

//倒计时按钮名称
- (void)setCacheName:(NSString *)cacheName{
    _cacheName = cacheName;
}

#pragma -mark count down method
- (void)startWithSecond:(NSInteger)second{
    
    _second = second;
    
    __block NSInteger time = 0;
    NSString *locaTime = [LocalDataTool readDataDefaultsWithForKey:self.cacheName];
    
    if ([locaTime integerValue] == 0) {
        time = second; //倒计时时间
        [LocalDataTool writeDataDefaultsValue:@(time) withForKey:self.cacheName];
    }else{
        time = [locaTime integerValue];
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(self->_timer);
            [LocalDataTool removeDataDefaultsWhiteForKey:self.cacheName];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.userInteractionEnabled = YES;
                if (self->_didFinishedBlock){
                    self->_didFinishedBlock(self);
                }
            });
            
        }else{
            
            int seconds = time % 60;
            [LocalDataTool writeDataDefaultsValue:@(seconds) withForKey:self.cacheName];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.userInteractionEnabled = NO;
                if (self->_didChangeBlock){
                    self->_didChangeBlock(self,seconds);
                }
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)stop{
    
    if (_timer) {
        dispatch_source_cancel(_timer);
        [LocalDataTool removeDataDefaultsWhiteForKey:self.cacheName];
    }
}

- (void)didChange:(didChangeBlock)didChangeBlock{
    
    _didChangeBlock = [didChangeBlock copy];
}

- (void)didFinished:(didFinishedBlock)didFinishedBlock{
    _didFinishedBlock = [didFinishedBlock copy];
}

@end
