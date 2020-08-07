//
//  LabelView.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/5/27.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "LabelView.h"

@interface LabelView ()

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UILabel *label2;
@property (nonatomic, strong)UILabel *label3;


@end

@implementation LabelView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initWithInitialization];
    }
    
    return self;
}

- (void)adArray:(NSArray <AdModel *>*)array{
    self.label.text = array.firstObject.title;
}

- (void)mainArray:(NSArray <MainModel *>*)array {
    self.label2.text = array.firstObject.title;
}

- (void)specialArray:(NSArray <SpecialModel*>*)array {
    self.label3.text = array.firstObject.imagePath;
}


#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    self.label = [[UILabel alloc] init];
    self.label.text = @"1";
    self.label.numberOfLines = 0;
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.right.equalTo(self);
        
    }];
    
    
    self.label2 = [[UILabel alloc] init];
    self.label2.text = @"2";
    self.label2.numberOfLines = 0;
    self.label2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label2];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label.mas_bottom).offset(20);
        make.left.right.equalTo(self);
    }];
    
    
    self.label3 = [[UILabel alloc] init];
    self.label3.text = @"3";
    self.label3.numberOfLines = 0;
    self.label3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label3];
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label2.mas_bottom).offset(20);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}

@end
