//
//  GoodsDetailHeaderView.m
//  SYDeBug
//
//  Created by xiesiyu on 2019/11/11.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "GoodsDetailHeaderView.h"

@implementation GoodsDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor orangeColor];
        [self initWithInitialization];
    }
    
    return self;
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    UIImageView *contentView = [[UIImageView alloc] init];
    contentView.image = IMG(@"1");
    contentView.contentMode = UIViewContentModeScaleAspectFill;
    contentView.clipsToBounds = YES;
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

@end
