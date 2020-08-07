//
//  SYiCarouselViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/8/6.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SYiCarouselViewController.h"
#import <iCarousel.h>
#import "SYProgressHUD.h"
#import <YYLabel.h>

@interface SYiCarouselViewController () <iCarouselDataSource,iCarouselDelegate>

@property (nonatomic, strong)iCarousel *syiCarousel;
@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation SYiCarouselViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        [_dataSource addObject:@"1"];
        [_dataSource addObject:@"1"];
        [_dataSource addObject:@"1"];
        [_dataSource addObject:@"1"];
        [_dataSource addObject:@"1"];
        [_dataSource addObject:@"1"];
        [_dataSource addObject:@"1"];
        [_dataSource addObject:@"1"];
    }
    return _dataSource;
}

- (iCarousel *)syiCarousel{

    CGFloat height = 120;
    if (!_syiCarousel) {
        _syiCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        _syiCarousel.backgroundColor = [UIColor whiteColor];
        _syiCarousel.dataSource = self;
        _syiCarousel.delegate = self;
        _syiCarousel.bounces = NO;
        _syiCarousel.pagingEnabled = YES;
        _syiCarousel.type = iCarouselTypeCustom;
        _syiCarousel.clipsToBounds = YES;
    }
    return _syiCarousel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.syiCarousel];
    
    
    //内容
    NSString *agrestString = @"《用户协议》";
    NSString *privacyString = @"《隐私条款》";
    
    
    NSMutableAttributedString *agressText  = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"感谢您选择它福APP!\n我们非常重视您的个人信息和隐私保护，为了更好地保障您的个人权益，在您使用我们的产品前，请务必审慎阅读%@与%@内的所有条款,尤其是:\n1.我们对您的个人信息的收集/保存/使用/对外提供/保护等规则条款，以及您的用户权利等条款;\n2.约定我们的限制责任、免责条款。\n您点击“同意\"的行为即表示您已阅读完毕并同意以上协议的全部内容。",agrestString,privacyString] attributes:@{NSKernAttributeName:@(1.5f)}];
    
    agressText.lineSpacing = 5;
    agressText.font = [UIFont systemFontOfSize:13];
    agressText.color = [UIColor blackColor];
    agressText.alignment = NSTextAlignmentLeft;
    [agressText setTextHighlightRange:[[agressText string] rangeOfString:agrestString] color:[UIColor colorWithHexString:@"#0078FF"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
       
    }];
    
    [agressText setTextHighlightRange:[[agressText string] rangeOfString:privacyString] color:[UIColor colorWithHexString:@"#0078FF"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
       
    }];
    
    YYLabel *contentLabel = [[YYLabel alloc] init];
    contentLabel.numberOfLines = 0;  //设置多行显示
    contentLabel.preferredMaxLayoutWidth = kScreenWidth - 60; //设置最大的宽度
    contentLabel.attributedText = agressText;  //设置富文本

    [self.view addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.syiCarousel.mas_bottom).offset(20);
        make.left.equalTo(self.syiCarousel).offset(16);
        make.right.equalTo(self.syiCarousel).offset(-16);
        make.height.mas_equalTo(200);
    }];
    
    
    
    
    
    
    
    
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.dataSource.count;
    
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    CGFloat height = 120;
    if (view == nil) {
        
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-120, height)];
    }
    UIImageView *pointView = (UIImageView *)view;
    pointView.backgroundColor = [UIColor lightGrayColor];
    pointView.image = [UIImage imageNamed:[self.dataSource objectAtIndex:index]];
    pointView.contentMode = UIViewContentModeScaleAspectFill;
    pointView.layer.cornerRadius = 4;
    pointView.layer.masksToBounds = YES;
    
    return view;
}


#pragma mark - iCarouselDelegate
- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
    
    static CGFloat max_sacle = 1.0f;
    static CGFloat min_scale = 0.6f;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    
    return CATransform3DTranslate(transform, offset * self.syiCarousel.itemWidth * 1.4, 0.0, 0.0);
}


- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}


- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    [SYProgressHUD messageSuccess:@"成功了"];
}


@end
