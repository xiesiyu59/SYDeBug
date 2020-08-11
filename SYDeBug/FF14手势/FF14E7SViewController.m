//
//  FF14E7SViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/7/28.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "FF14E7SViewController.h"
#import "UIView+SYView.h"

@interface FF14E7SViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)UIView *hostedView;
@property (nonatomic, strong)UIView *statrView;
@property (nonatomic, strong)UIView *endView;
@property (nonatomic, strong)UIView *rowView;

@property (nonatomic, strong)UILabel *roleOrientedLabel;

@property (nonatomic, strong)UILabel *rowLabel;

@property (nonatomic, assign)int indexTag;
@property (nonatomic, assign)NSInteger buttonTag;



@end

@implementation FF14E7SViewController


- (BOOL)sy_preferredNavigationBarHidden {
    
    return YES;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.buttonTag = 0;
    self.indexTag = [self getRandomNumber:1 to:4];
    
    [self initWithInitialization:self.indexTag];
    
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
    [refreshButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refreshButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshButton];
    [refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarSpeac+20);
        make.left.equalTo(self.view).offset(30);
    }];
    
    
    UIButton *wButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [wButton setTitle:@"W" forState:UIControlStateNormal];
    [wButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [wButton setLXBorderWidth:1 borderColor:[UIColor blackColor]];
    [wButton addTarget:self action:@selector(wButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wButton];
    [wButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(20);
        make.centerX.equalTo(self.collectionView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    
    UIButton *sButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sButton setTitle:@"S" forState:UIControlStateNormal];
    [sButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sButton setLXBorderWidth:1 borderColor:[UIColor blackColor]];
    [sButton addTarget:self action:@selector(sButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sButton];
    [sButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wButton.mas_bottom).offset(20);
        make.centerX.equalTo(self.collectionView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setTitle:@"A" forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aButton setLXBorderWidth:1 borderColor:[UIColor blackColor]];
    [aButton addTarget:self action:@selector(aButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aButton];
    [aButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wButton.mas_bottom).offset(-10);
        make.left.equalTo(wButton.mas_left).offset(-50);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    
    UIButton *dButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dButton setTitle:@"D" forState:UIControlStateNormal];
    [dButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dButton setLXBorderWidth:1 borderColor:[UIColor blackColor]];
    [dButton addTarget:self action:@selector(dButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dButton];
    [dButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wButton.mas_bottom).offset(-10);
        make.right.equalTo(wButton.mas_right).offset(50);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    
}



#pragma mark - <初始化界面>
- (void)initWithInitialization:(int)x {
 
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:UICollectionViewCell.className];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-40);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width);
    }];
    
    NSLog(@"%d",x);
    self.hostedView = [[UIView alloc] init];
    self.hostedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.hostedView];
    
    switch (x) {
        case 1:{
            [self.hostedView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(80);
                make.height.mas_equalTo(kScreenWidth-160);
                make.center.equalTo(self.view);
            }];
            self.hostedView.layer.anchorPoint = CGPointMake(0.5, 0);
        }break;
        case 3:{
            [self.hostedView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(80);
                make.height.mas_equalTo(kScreenWidth-160);
                make.center.equalTo(self.view);
            }];
            self.hostedView.layer.anchorPoint = CGPointMake(0.5, 1);
        }break;
        case 2:{
            [self.hostedView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kScreenWidth-160);
                make.height.mas_equalTo(80);
                make.center.equalTo(self.view);
            }];
            self.hostedView.layer.anchorPoint = CGPointMake(1, 0.5);
        }break;
        case 4:{
            [self.hostedView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kScreenWidth-160);
                make.height.mas_equalTo(80);
                make.center.equalTo(self.view);
            }];
            self.hostedView.layer.anchorPoint = CGPointMake(0, 0.5);
        }break;
            
        default:break;
    }
    
    
    
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [self.hostedView addGestureRecognizer:rotationGestureRecognizer];

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.hostedView addGestureRecognizer:panGestureRecognizer];


    self.statrView = [[UIView alloc] init];
    self.statrView.backgroundColor = [UIColor purpleColor];
    [self.statrView setLXCornerdious:40];
    [self.hostedView addSubview:self.statrView];
    
    
    self.endView = [[UIView alloc] init];
    self.endView.backgroundColor = [UIColor purpleColor];
    [self.endView setLXCornerdious:40];
    [self.hostedView addSubview:self.endView];
    
    
    self.rowView = [[UIView alloc] init];
    self.rowView.backgroundColor = [UIColor purpleColor];
    [self.hostedView addSubview:self.rowView];
    
    self.rowLabel = [[UILabel alloc] init];
    self.rowLabel.textColor = [UIColor yellowColor];
    [self.rowView addSubview:self.rowLabel];
    [self.rowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.rowView);
    }];
    
    
    switch (x) {
        case 1:{
            [self.statrView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.hostedView);
                make.size.mas_equalTo(CGSizeMake(80, 80));
            }];
            
            [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.hostedView);
                make.size.mas_equalTo(CGSizeMake(80, 80));
            }];
            
            [self.rowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.statrView.mas_bottom).offset(-15);
                make.bottom.equalTo(self.endView.mas_top).offset(15);
                make.width.mas_equalTo(60);
                make.centerX.equalTo(self.hostedView.mas_centerX);
            }];
            self.rowLabel.text = @"↓";
        }break;
        case 2:{
            
            [self.statrView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.hostedView);
                make.size.mas_equalTo(CGSizeMake(80, 80));
            }];
            [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.hostedView);
                make.size.mas_equalTo(CGSizeMake(80, 80));
            }];
            
            [self.rowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.endView.mas_right).offset(-15);
                make.right.equalTo(self.statrView.mas_left).offset(15);
                make.height.mas_equalTo(60);
                make.centerY.equalTo(self.hostedView.mas_centerY);
            }];
            self.rowLabel.text = @"←";
        }break;
        case 3:{
            [self.statrView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.hostedView);
                make.size.mas_equalTo(CGSizeMake(80, 80));
            }];
            [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.hostedView);
                make.size.mas_equalTo(CGSizeMake(80, 80));
            }];
            [self.rowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.endView.mas_bottom).offset(-15);
                make.bottom.equalTo(self.statrView.mas_top).offset(15);
                make.width.mas_equalTo(60);
                make.centerX.equalTo(self.hostedView.mas_centerX);
            }];
            
            self.rowLabel.text = @"↑";
        }break;
        case 4:{
            [self.statrView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.hostedView);
                make.size.mas_equalTo(CGSizeMake(80, 80));
            }];
            [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.hostedView);
                make.size.mas_equalTo(CGSizeMake(80, 80));
            }];
            [self.rowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.statrView.mas_right).offset(-15);
                make.right.equalTo(self.endView.mas_left).offset(15);
                make.height.mas_equalTo(60);
                make.centerY.equalTo(self.hostedView.mas_centerY);
            }];
            self.rowLabel.text = @"→";
        }break;
            
        default:break;
    }
    
    self.roleOrientedLabel = [[UILabel alloc] init];
    self.roleOrientedLabel.text = @"↑";
    self.roleOrientedLabel.textColor = [UIColor redColor];
    [self.statrView addSubview:self.roleOrientedLabel];
    [self.roleOrientedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.statrView.mas_centerX);
        make.centerY.equalTo(self.statrView.mas_centerY).offset(-10);
    }];
    
}


#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UICollectionViewCell.className forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

#pragma mark -UICollectionViewDelegateFlowLayout
//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = floor((kScreenWidth)/4);
    return CGSizeMake(width, width);
}

//间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
//横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}



- (void)rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer{
    
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged){
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}


- (void)panView:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){
            view.center.x + translation.x, view.center.y + translation.y
        }];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}

- (void)refreshButton{
    
    [self.hostedView removeFromSuperview];
    self.indexTag = [self getRandomNumber:1 to:4];
    [self initWithInitialization:self.indexTag];
    
}


- (void)wButton:(UIButton *)sender{
    
}


- (void)sButton:(UIButton *)sender{
    
    
}

- (void)aButton:(UIButton *)sender{
    
    
}

- (void)dButton:(UIButton *)sender{
    
    
}


- (int)getRandomNumber:(int)from to:(int)to {
    
    return (int)(from + (arc4random() % (to - from + 1)));
}

@end

