//
//  SYToast.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/18.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SYToast.h"

@interface SYToast()

/**  */
@property (nonatomic, strong) NSString *message;

/**  */
@property (nonatomic, strong) NSTimer *timer;

/**  */
@property (nonatomic, assign) BOOL isOnScreen;

/**  */
//@property (nonatomic, assign) CGFloat keyboardHeight;

/**  */

@property (nonatomic, assign) NSTimeInterval duration;

/**  */
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation SYToast{
    
    BOOL _keyboardIsVisible;
}

//10-5  20-8 默认 3
#pragma mark - Public Method
+ (void)showWithMessage:(NSString *)message{
    NSTimeInterval showTime = 0.0;
    if (message.length < 10) {
        showTime = 3.0;
    } else
    if (message.length>=10 && message.length<20 ) {
        showTime = 5.0;
    } else if(message.length>=20 ){
        showTime = 8.0;
    }
    [SYToast showWithMessage:message duration:showTime];
}

+ (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration{
    if (message.length == 0) {
        NSAssert(NO, @"Message can not be nil~");
        return;
    }
    SYToast *toast = [SYToast sharedInstance];
    toast.duration = duration;
    toast.message = message;
    [toast showOnScreen];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:toast];
}

#pragma mark - Private Method
- (void)showOnScreen{
    if (self.isOnScreen) {
        [[NSRunLoop currentRunLoop]cancelPerformSelector:@selector(removeFromScreen) target:self argument:nil];
    }else{
        //animation
        self.isOnScreen = YES;
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow layoutIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1.f;
            if (self->_keyboardIsVisible) {
                [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(keyWindow);
                }];
            }else{
                [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(keyWindow);
                    make.bottom.equalTo(keyWindow.mas_bottom).offset(-60);
                }];
            }
            
            
            [keyWindow layoutIfNeeded];
            
        } completion:^(BOOL finished) {
        }];
    }
    
    
    [self.timer invalidate];
    self.timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:_duration]
                                          interval:0
                                            target:self
                                          selector:@selector(removeFromScreen)
                                          userInfo:nil
                                           repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeFromScreen{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        if (finished) {
            self.isOnScreen = NO;
            self.contentLabel.text = @"*";
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            [keyWindow layoutIfNeeded];
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(keyWindow);
                make.top.equalTo(keyWindow.mas_bottom);
            }];
            [keyWindow layoutIfNeeded];
        }
    }];
}

- (void)setMessage:(NSString *)message{
    _message = message;
    
    self.contentLabel.text = message;
    [self.contentLabel sizeToFit];
}


#pragma mark - Initialization
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static SYToast *toast;
    dispatch_once(&onceToken, ^{
        toast = [[SYToast alloc]init];
        
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:toast];
        [toast mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(keyWindow);
            make.top.equalTo(keyWindow.mas_bottom);
        }];
    });
    return toast;
}

- (instancetype)init{
    if (self = [super init]) {
        
        [self initSubviews];
        
    }
    return self;
}




- (void)initSubviews {
    self.layer.masksToBounds = YES;
    
    //base height = 34;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardWillHideNotification object:nil];
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:.6];
    
    self.contentLabel = [[UILabel alloc]init];
    
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.preferredMaxLayoutWidth = kScreenWidth - 108;
    
    //(17 + 2 * 8)/2.f;
    self.layer.cornerRadius = 2;
    
    [self addSubview:self.contentLabel];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(8, 12, 8, 12));
    }];
    
}


//Keyboard Show/Hide Method
- (void)keyboardDidShow{
    _keyboardIsVisible = YES;
}

- (void)keyboardDidHide{
    _keyboardIsVisible = NO;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
