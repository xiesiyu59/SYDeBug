//
//  SYActionSheetCell.m
//  Footstone
//
//  Created by xiesiyu on 2020/8/28.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SYActionSheetCell.h"

@interface SYActionSheetCell ()


@property (nonatomic, strong)UIView *syContentView;


@end

@implementation SYActionSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initWithInitialization];
    }
    
    return self;
    
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    self.syContentView = [[UIView alloc] init];
    [self.contentView addSubview:self.syContentView];
    [self.syContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    
    self.iconImageView = [[UIImageView alloc] init];
    [self.syContentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.syContentView);
        make.left.equalTo(self.syContentView);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.bottom.equalTo(self.syContentView.mas_bottom);
    }];
    
    self.titleLabel = [BaseClassTool labelWithFont:15 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(8);
        make.centerY.equalTo(self.iconImageView.mas_centerY);
        make.right.equalTo(self.syContentView.mas_right);
    }];
    
}

@end
