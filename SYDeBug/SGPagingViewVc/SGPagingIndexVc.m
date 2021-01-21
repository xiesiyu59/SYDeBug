//
//  SGPagingIndexVc.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/1/21.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SGPagingIndexVc.h"
#import "SGPagingListVc.h"
#import "SGPagingView.h"
#import "UIScrollView+GestureConflict.h"

@interface SGPagingIndexVc () <SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic, assign) CGFloat sgPageHeight;
@property (nonatomic, assign) NSInteger currentIndex;   //当前列表

@end

@implementation SGPagingIndexVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"多个选项";
    [self initWithInitialization];
    
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    self.sgPageHeight = 44;
    
    NSArray *titleArr = @[@"党务通知",@"公务通知",@"系统通知"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleFont = [UIFont boldSystemFontOfSize:16];
    configure.titleSelectedFont = [UIFont boldSystemFontOfSize:16];
    
    configure.indicatorHeight = 4;
    configure.indicatorCornerRadius = 2;
    configure.indicatorToBottomDistance = 1;
    
    configure.indicatorStyle = SGIndicatorStyleFixed;
    configure.indicatorFixedWidth = 45;
    
    configure.titleColor = [UIColor blackColor];
    configure.titleSelectedColor = [UIColor redColor];
    
    configure.indicatorColor = [UIColor redColor];
    configure.showBottomSeparator = NO;
    configure.bottomSeparatorColor = [UIColor lightGrayColor];
    
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, kOnePx, kScreenWidth, self.sgPageHeight) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView.backgroundColor = [UIColor whiteColor];
    
    //未选中
    [self.pageTitleView resetColor:[UIColor redColor] forIndex:0];
    [self.pageTitleView resetColor:[UIColor blueColor] forIndex:1];
    [self.pageTitleView resetColor:[UIColor yellowColor] forIndex:2];
    
    //选中
    [self.pageTitleView resetSelectColor:[UIColor redColor] forIndex:0];
    [self.pageTitleView resetSelectColor:[UIColor blueColor] forIndex:1];
    [self.pageTitleView resetSelectColor:[UIColor yellowColor] forIndex:2];
    
    [self.view addSubview:self.pageTitleView];
    
    //添加控制器
    NSMutableArray *childArr = [NSMutableArray array];
    for (NSInteger i = 0; i < titleArr.count; i ++) {
        
        //@"党务通知",@"工作通知",@"系统通知"
        SGPagingListVc *vc = [[SGPagingListVc alloc] init];
        [childArr addObject:vc];
    }
    
    /// pageContentScrollView
    CGFloat contentViewHeight = kScreenHeight - self.sgPageHeight - kScreenTopIsX-kScreenBottomIsX-kOnePx;
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageTitleView.frame), kScreenWidth, contentViewHeight) parentVC:self childVCs:childArr];
    self.pageContentScrollView.delegatePageContentScrollView = self;
    self.pageContentScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pageContentScrollView];
    
    //分割线
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self.pageTitleView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.pageTitleView.mas_bottom);
        make.left.right.equalTo(self.pageTitleView);
        make.height.mas_equalTo(1);
    }];
    
    
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {
    /// 说明：在此获取标题or当前子控制器下标值
    self.currentIndex = index;
    switch (self.currentIndex) {
        case 0:{
            [self.pageTitleView resetIndicatorColor:[UIColor redColor]];
        }break;
        case 1:{
            [self.pageTitleView resetIndicatorColor:[UIColor blueColor]];
        }break;
        case 2:{
            [self.pageTitleView resetIndicatorColor:[UIColor yellowColor]];
        }break;
            
        default:break;
    }
}



@end
