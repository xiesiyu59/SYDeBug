//
//  FileDownloadCell.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/9.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "FileDownloadCell.h"
#import "SYDownLoader.h"
#import "UIView+SYView.h"

@interface FileDownloadCell ()

@property (nonatomic, assign)LoadType type;
@property (nonatomic, strong)SYDownLoader *downLoader;
@property (nonatomic,strong)UIButton *startButton;
@property (nonatomic,strong)UIButton *suspendButton;
@property (nonatomic,strong)UIButton *continueButton;




@end

@implementation FileDownloadCell

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
    
    self.fileImageView = [[UIImageView alloc] init];
    self.fileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.fileImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.fileImageView];
    [self.fileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView).offset(16);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    
    self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.startButton setTitle:@"开始下载" forState:UIControlStateNormal];
    [self.startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.startButton];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fileImageView.mas_top);
        make.left.equalTo(self.fileImageView.mas_right).offset(16);
    }];
    
    
    self.suspendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.suspendButton setTitle:@"暂停下载" forState:UIControlStateNormal];
    [self.suspendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.suspendButton];
    [self.suspendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startButton.mas_top);
        make.left.equalTo(self.startButton.mas_right).offset(16);
    }];
    
    
    self.continueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.continueButton setTitle:@"继续下载" forState:UIControlStateNormal];
    [self.continueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.continueButton];
    [self.continueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startButton.mas_top);
        make.left.equalTo(self.suspendButton.mas_right).offset(16);
    }];
    
//    self.downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.downloadButton setTitle:@"下载" forState:UIControlStateNormal];
//    self.downloadButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [self.downloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.downloadButton.backgroundColor = [UIColor orangeColor];
//    [self.downloadButton setLXCornerdious:4];
//    [self.contentView addSubview:self.downloadButton];
//    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.suspendButton.mas_bottom);
//        make.left.equalTo(self.showLabel.mas_right).offset(16);
//        make.size.mas_equalTo(CGSizeMake(80, 32));
//    }];
    
    self.downloadButton = [[SYDownloadButton alloc] init];
    self.downloadButton.backgroundColor = [UIColor orangeColor];
    [self.downloadButton setLXCornerdious:4];
    [self.contentView addSubview:self.downloadButton];
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startButton.mas_bottom);
        make.left.equalTo(self.startButton.mas_left);
        make.size.mas_equalTo(CGSizeMake(80, 32));
    }];
    
    
    [self.startButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.suspendButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.continueButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.downloadButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.downloadButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBack:)]];
    
}


- (void)buttonClick:(UIButton *)sender{
    
    sender.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.userInteractionEnabled = YES;
    });
    if (sender == self.startButton) {
        self.type = LoadTypeStart;
    }else if (sender == self.suspendButton){
        self.type = LoadTypeSuspend;
    }else if (sender == self.continueButton){
        self.type = LoadTypeStart;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickType:didCell:)]) {
        [self.delegate buttonClickType:self.type didCell:self];
    }
}

- (void)goBack:(UITapGestureRecognizer *)tap{
    
    if (self.downloadButton.present == 100) {
        return;
    }
    if (self.downloadButton.isDownlod) {
        self.type = LoadTypeSuspend;
    }else{
        self.type = LoadTypeStart;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickType:didCell:)]) {
        [self.delegate buttonClickType:self.type didCell:self];
    }
}

@end
