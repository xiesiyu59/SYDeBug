//
//  SYCustomButton.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/24.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYCustomButton.h"

@interface SYCustomButton ()

@property (nonatomic, strong)UIImageView *btnImageView;
@property (nonatomic, strong)UILabel *btnLabel;

@end

@implementation SYCustomButton

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
    
    self.btnImageView = [[UIImageView alloc] init];
    [self addSubview:self.btnImageView];
    
    self.btnLabel = [[UILabel alloc] init];
    self.btnLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.btnLabel];
    
}

- (void)setCoustBtnAlignement:(SYButtonAlignment)alignment itemSpace:(CGFloat)itemSpace image:(UIImage *)image title:(NSString *)title{
    
    if (image && title) {
        
        self.btnImageView.image = image;
        self.btnLabel.text = title;
        CGSize imageSize = image.size;
        
        switch (alignment) {
            case SYImageLeftTitleRight:{
                
                [self.btnImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self).offset(10);
                    make.left.equalTo(self).offset(10);
                    make.bottom.equalTo(self.mas_bottom).offset(-10);
                    make.size.mas_equalTo(imageSize);
                }];
                [self.btnLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.btnImageView.mas_centerY);
                    make.left.equalTo(self.btnImageView.mas_right).offset(itemSpace);
                    make.right.equalTo(self.mas_right).offset(-10);
                }];
                
            }break;
            case SYImageRightTitleLeft:{
                
                [self.btnImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self).offset(10);
                    make.right.equalTo(self.mas_right).offset(-10);
                    make.bottom.equalTo(self.mas_bottom).offset(-10);
                    make.size.mas_equalTo(imageSize);
                }];
                [self.btnLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.btnImageView.mas_centerY);
                    make.right.equalTo(self.btnImageView.mas_left).offset(-itemSpace);
                    make.left.equalTo(self).offset(10);
                }];
                
            }break;
            case SYImageTopTitleBottom:{
                
                [self.btnImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self).offset(10);
                    make.centerX.equalTo(self.mas_centerX);
                    make.size.mas_equalTo(imageSize);
                    
                }];
                
                [self.btnLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.centerX.equalTo(self.btnImageView.mas_centerX);
                    make.right.equalTo(self.mas_right).offset(-10);
                    make.left.equalTo(self).offset(10);
                    make.top.equalTo(self.btnImageView.mas_bottom).offset(itemSpace);
                    make.bottom.equalTo(self.mas_bottom).offset(-10);
                    
                }];
                
            }break;
            case SYImageBottomTitleTop:{
                
                [self.btnImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.bottom.equalTo(self.mas_bottom).offset(-10);
                    make.centerX.equalTo(self.mas_centerX);
                    make.size.mas_equalTo(imageSize);
                    
                }];
                
                [self.btnLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.centerX.equalTo(self.btnImageView.mas_centerX);
                    make.right.equalTo(self.mas_right).offset(-10);
                    make.left.equalTo(self).offset(10);
                    make.top.equalTo(self).offset(10);
                    make.bottom.equalTo(self.btnImageView.mas_top).offset(-itemSpace);
                    
                }];
                
            }break;
                
            default:break;
        }
        
    }
    
}

- (void)setImage:(UIImage *)image{
    _image = image;
    self.btnImageView.image = image;
    [self.btnImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.mas_equalTo(self.btnImageView.mas_height);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
}

- (void)setTitle:(NSString *)title{
    
    _title = title;
    self.btnLabel.text = title;
    [self.btnLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.btnImageView.mas_right).offset(4);
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.mas_equalTo(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
}

- (void)setFont:(UIFont *)font{
    _font = font;
    self.btnLabel.font = font;
}

@end
