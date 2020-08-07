//
//  OnPullMsgView.m
//  SYDeBug
//
//  Created by xiesiyu on 2019/11/11.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "OnPullMsgView.h"

@implementation OnPullMsgView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initWithInitialization];
    }
    
    return self;
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"继续往下有惊喜";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
}

@end
