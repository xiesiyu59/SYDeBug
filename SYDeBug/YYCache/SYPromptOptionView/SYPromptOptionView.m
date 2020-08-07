//
//  SYPromptOptionView.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/7/17.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SYPromptOptionView.h"

#define PromptOptionViewHeight 240

@interface SYPromptOptionView ()

@property (nonatomic, assign) BOOL isBottom;

@property (nonatomic, strong) NSString *contentStr;

@property (nonatomic, strong) NSString *successTitle;
@property (nonatomic, copy  ) void (^successBlock)(void);
@property (nonatomic, strong) NSString *cancelTitle;
@property (nonatomic, copy  ) void (^cancelBlock)(void);

@end

@implementation SYPromptOptionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow  addSubview:self];
    }
    
    return self;
}


+ (void)showWithContentStr:(NSString *)content
               successTitle:(NSString *)successTitle
              successBlock:(void (^__nullable)(void ))successBlock
               cancelTitle:(NSString *)cancelTitle
               cancelBlock:(void (^__nullable)(void ))cancelBlock{
    
    SYPromptOptionView *promptOptionView = [[SYPromptOptionView alloc]initWithFrame:CGRectMake(0, -PromptOptionViewHeight, kScreenWidth, PromptOptionViewHeight)];
    promptOptionView.isBottom = NO;
    promptOptionView.contentStr = content;
    promptOptionView.successTitle = successTitle;
    promptOptionView.successBlock = successBlock;
    promptOptionView.cancelTitle = cancelTitle;
    promptOptionView.cancelBlock = cancelBlock;
    [promptOptionView showPromptView];
    
}


+ (void)showWithBottomContentStr:(NSString *)content
               successTitle:(NSString *)successTitle
              successBlock:(void (^__nullable)(void))successBlock
               cancelTitle:(NSString *)cancelTitle
               cancelBlock:(void (^__nullable)(void ))cancelBlock{
    
    SYPromptOptionView *promptOptionView = [[SYPromptOptionView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, PromptOptionViewHeight)];
    promptOptionView.isBottom = YES;
    promptOptionView.contentStr = content;
    promptOptionView.successTitle = successTitle;
    promptOptionView.successBlock = successBlock;
    promptOptionView.cancelTitle = cancelTitle;
    promptOptionView.cancelBlock = cancelBlock;
    [promptOptionView showPromptView];
    
}


#pragma mark - <初始化界面>
- (void)showPromptView{
    
    [UIView animateWithDuration:.33 animations:^{
        if (!self.isBottom) {
            self.transform = CGAffineTransformMakeTranslation(0,PromptOptionViewHeight);
        }else{
            self.transform = CGAffineTransformMakeTranslation(0,-PromptOptionViewHeight);
        }
    }];
    
    //阴影
    if (!self.isBottom) {
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.05f;
        self.layer.shadowRadius = 4.f;
        self.layer.shadowOffset = CGSizeMake(0,5);
    }else{
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.05f;
        self.layer.shadowRadius = 4.f;
        self.layer.shadowOffset = CGSizeMake(0,-5);
    }
    
    
    CGSize buttonSize = CGSizeMake((kScreenWidth-36*2)/2, 44);
    CGSize buttonOneSize = CGSizeMake(kScreenWidth-36*2, 44);
    //左按钮
    UIButton *leftButton = [[UIButton alloc] init];
    leftButton.layer.cornerRadius = buttonSize.height/2;
    leftButton.backgroundColor = [UIColor grayColor];
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [leftButton setTitle:self.cancelTitle forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];
    
    //右按钮
    UIButton *rightButton = [[UIButton alloc] init];
    rightButton.layer.cornerRadius = buttonSize.height/2;
    [rightButton setBackgroundColor:[UIColor grayColor]];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [rightButton setTitle:self.successTitle forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
    
    if ([self.cancelTitle isEqualToString:@""]) {
        
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-16);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(buttonOneSize);
        }];
        
    }else{
        
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-16);
            make.left.equalTo(self).offset(16);
            make.size.mas_equalTo(buttonSize);
        }];
        
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-16);
            make.right.equalTo(self).offset(-16);
            make.size.mas_equalTo(buttonSize);
        }];
    }
    
    //内容
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.numberOfLines = 0;
    contentLabel.text = self.contentStr;
    [self addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kStatusBarSpeac+16);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.bottom.lessThanOrEqualTo(rightButton.mas_top).offset(-16);
    }];
    
}

- (void)leftButton:(UIButton *)sender {
    
    if (self.cancelBlock) {
        [self hideFromWindowCompletedHandler:^{
            self.cancelBlock();
            self.cancelBlock = nil;
        }];
    }else{
        [self hideFromWindowCompletedHandler:nil];
    }
    
}

- (void)rightButton:(UIButton *)sender {
    
    if (self.successBlock) {
        [self hideFromWindowCompletedHandler:^{
            self.successBlock();
            self.successBlock = nil;
        }];
    }else{
        [self hideFromWindowCompletedHandler:nil];
    }
}


- (void)hideFromWindowCompletedHandler:(void(^)(void))completedHandler{
    [UIView animateWithDuration:.33 animations:^{
        if (!self.isBottom) {
            self.transform = CGAffineTransformMakeTranslation(0, -PromptOptionViewHeight);
        }else{
            self.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
        }
        
    } completion:^(BOOL finished) {
        if (completedHandler) {
            completedHandler();
        }
        [self removeFromSuperview];
    }];
}

@end
