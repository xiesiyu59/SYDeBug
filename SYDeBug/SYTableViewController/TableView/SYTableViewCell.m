//
//  SYTableViewCell.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/7.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYTableViewCell.h"

@implementation SYTableViewCell

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
    
    self.backgroundColor = [UIColor colorWithRed:arc4random() % 255/255.0 green:arc4random() % 255/255.0 blue:arc4random() % 255/255.0 alpha:1.0];
    
}

@end
