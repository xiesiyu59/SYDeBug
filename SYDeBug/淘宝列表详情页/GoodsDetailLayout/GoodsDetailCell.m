//
//  GoodsDetailCell.m
//  SYDeBug
//
//  Created by xiesiyu on 2019/11/11.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "GoodsDetailCell.h"

@implementation GoodsDetailCell

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
    
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.height.mas_equalTo(kOnePx);
    }];
    
}

@end
