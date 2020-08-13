//
//  SYGuideMaskViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/8/12.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SYGuideMaskViewController.h"
#import "SYGuideMaskView.h"

@interface SYGuideMaskViewController ()

@property (nonatomic, strong)UILabel *textLabel;
@property (nonatomic, strong)UIButton *tapBtn;
@property (nonatomic, strong)UIImageView *bgImg;

@end

@implementation SYGuideMaskViewController


- (BOOL)sy_preferredNavigationBarHidden{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textLabel = [BaseClassTool labelWithFont:16 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
    self.textLabel.text = @"这是一个引导页";
    [self.view addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(120);
        make.left.equalTo(self.view).offset(200);
    }];
    
    self.tapBtn = [BaseClassTool buttonWithFont:16 titleColor:[UIColor blackColor] contentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter title:@"我是一个按钮"];
    [self.view addSubview:self.tapBtn];
    [self.tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLabel.mas_bottom).offset(80);
        make.left.equalTo(self.view).offset(20);
    }];
    
    
    self.bgImg = [[UIImageView alloc] init];
    self.bgImg.image = [UIImage imageNamed:@"liu"];
    [self.view addSubview:self.bgImg];
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tapBtn.mas_centerY);
        make.left.equalTo(self.tapBtn.mas_right).offset(40);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.view layoutIfNeeded];
    [self setupGuideView];
}

- (void)setupGuideView{
        
    NSArray * imageArr = @[@"image_01",@"image_02",@"image_03"];
    CGRect rect1 = self.textLabel.frame;
    CGRect rect2 = self.tapBtn.frame;
    CGRect rect3 = self.bgImg.frame;
    NSArray * imgFrameArr = @[
                              [NSValue valueWithCGRect:CGRectMake(rect1.origin.x-118, CGRectGetMaxY(rect1)-123, 118, 123)],
                              [NSValue valueWithCGRect:CGRectMake(CGRectGetMaxX(rect2), rect2.origin.y-108, 206, 108)],
                              [NSValue valueWithCGRect:CGRectMake(CGRectGetMaxX(rect3)-80, CGRectGetMaxY(rect3), 144 , 113)]
                              ];
    NSArray * transparentRectArr = @[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3]];
    // @[@3]
    // @[@1,@1,@1]
    // @[@1,@2];
    NSArray * orderArr = @[@1,@1,@1];
    SYGuideMaskView *maskView = [SYGuideMaskView new];
    [maskView addImages:imageArr imageFrame:imgFrameArr TransparentRect:transparentRectArr orderArr:orderArr];
    [maskView showMaskViewInView:self.view];
    
}



@end
