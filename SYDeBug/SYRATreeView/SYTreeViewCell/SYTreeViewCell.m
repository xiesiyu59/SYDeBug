//
//  SYTreeViewCell.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/3/29.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYTreeViewCell.h"

@implementation SYTreeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initWithInitialization];
    }
    
    return self;
    
}

- (void)syTreeViewCellWithModel:(RaTreeModel *)model level:(NSInteger)level children:(NSInteger)children{
    
    
    //有自孩子时显示图标
    if (children==0) {
        self.iconView.hidden = YES;
    }
    else { //否则不显示
        self.iconView.hidden = NO;
    }
    
    if (level == 0) {
        self.backgroundColor = [UIColor colorWithHexString:@"0xF7F7F7"];
    }else if (level == 1) {
        self.backgroundColor =  [UIColor colorWithHexString:@"0xD1EEFC"];
    }else if (level == 2) {
        self.backgroundColor =  [UIColor colorWithHexString:@"0xE0F8D8"];
    }else if (level == 3) {
        self.backgroundColor =  [UIColor colorWithHexString:@"0x778899"];
    }else if (level == 4) {
        self.backgroundColor =  [UIColor colorWithHexString:@"0xC0C0C0"];
    }
    
    self.titleLabel.text = model.name;
    if (model.isOpen) {
        self.iconView.backgroundColor = [UIColor orangeColor];
    }else{
        self.iconView.backgroundColor = [UIColor redColor];
    }
    
}

+ (instancetype)treeViewCellWith:(RATreeView *)treeView {
    
    static NSString *identifier = @"RaTreeViewCell";
    SYTreeViewCell *cell = [treeView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SYTreeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    self.titleLabel = [BaseClassTool labelWithFont:16 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.titleLabel];
    
    self.iconView = [[UIView alloc] init];
    [self.contentView addSubview:self.iconView];
    
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView).offset(16);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.iconView.mas_right).offset(10);
    }];
    
}

@end
