//
//  PTSSYHomeHotMainCell.m
//  PetStore
//
//  Created by xiesiyu on 2020/6/3.
//  Copyright © 2020 Petstore. All rights reserved.
//

#import "PTSSYHomeHotMainCell.h"

@interface PTSSYHomeHotMainCell ()


@end


@implementation PTSSYHomeHotMainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initWithInitialization];
    }
    
    return self;
    
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    self.videoPlayView = [[UIImageView alloc] init];
    self.videoPlayView.backgroundColor = [UIColor blackColor];
    self.videoPlayView.contentMode = UIViewContentModeScaleAspectFill;
    self.videoPlayView.clipsToBounds = YES;
    [self.contentView addSubview:self.videoPlayView];
    [self.videoPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
    self.suspendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.suspendButton addTarget:self action:@selector(suspendButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.suspendButton];
    [self.suspendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
    self.muteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.muteButton setImage:[UIImage imageNamed:@"图标默认"] forState:UIControlStateNormal];
    [self.muteButton setImage:[UIImage imageNamed:@"图标静音"] forState:UIControlStateSelected];
    [self.muteButton addTarget:self action:@selector(muteButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.muteButton];
    [self.muteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-60);
    }];
    
}


- (void)muteButton:(UIButton *)sedner{
    
    sedner.selected = !sedner.selected;
    if (self.muteBlock) {
        self.muteBlock(sedner.selected);
    }
}

- (void)suspendButton:(UIButton *)sedner{
    if (self.delegate && [self.delegate respondsToSelector:@selector(suspendDidClickCell:)]) {
        [self.delegate suspendDidClickCell:self];
    }
}


@end
