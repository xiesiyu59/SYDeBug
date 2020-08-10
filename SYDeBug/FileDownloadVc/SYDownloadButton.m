//
//  SYDownloadButton.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/8/7.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SYDownloadButton.h"
#import "UIView+SYView.h"

@interface SYDownloadButton ()

@end


@implementation SYDownloadButton

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
    
    self.loadView = [[UIView alloc] init];
    self.loadView.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.loadView];
    [self.loadView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.height.mas_equalTo(self);
    }];
    
    
    self.titleLabel = [[SYColorLabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"下载";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.blendColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}


- (void)setPresent:(CGFloat)present{
    _present = present;
    NSLog(@"%f",present);
    if (present == 100) {
        self.titleLabel.text = @"下载完成";
    }else{
        
        self.titleLabel.text = [NSString stringWithFormat:@"%.0f％",present];
        if (!self.isDownlod) {
            self.titleLabel.text = @"继续";
        }
    }
    self.titleLabel.colorRatio = present /100;
    [self.loadView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo(self.frame.size.width/100*present);
    }];
    
    
}

- (void)setIsDownlod:(BOOL)isDownlod{
    _isDownlod = isDownlod;
    
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.textColor = [UIColor orangeColor];
    [self setLXBorderWidth:1 borderColor:[UIColor orangeColor]];
    
}


@end
