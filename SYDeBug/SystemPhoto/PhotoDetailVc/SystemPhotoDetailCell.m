//
//  SystemPhotoDetailCell.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/6/16.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SystemPhotoDetailCell.h"

@interface SystemPhotoDetailCell ()



@end

@implementation SystemPhotoDetailCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        [self initWithInitialization];
    }
    
    return self;
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    self.lookImageView = [[UIImageView alloc] init];
    self.lookImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.lookImageView];
    [self.lookImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}

@end
