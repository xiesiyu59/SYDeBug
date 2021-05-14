//
//  SYDrawingBoardColorView.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/12.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYDrawingBoardColorView.h"

@interface SYDrawingBoardColorView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSArray *paintColor;       ///画笔颜色
@property (nonatomic, assign)CGFloat colorViewHeigt;

@end

@implementation SYDrawingBoardColorView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
       
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        [self initWithinitializationDataSource];
        [self initWithInitialization];
    }
    
    return self;
}

#pragma mark - <初始化数据源>
- (void)initWithinitializationDataSource {
    
    self.colorViewHeigt = 300;
    self.paintColor = @[[UIColor blackColor],[UIColor redColor],[UIColor orangeColor],[UIColor purpleColor],[UIColor blueColor],
    [UIColor yellowColor],[UIColor grayColor],[UIColor greenColor]];
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, self.colorViewHeigt) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:UICollectionViewCell.className];
    [self addSubview:self.collectionView];
}


#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.paintColor.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UICollectionViewCell.className forIndexPath:indexPath];
    cell.backgroundColor = self.paintColor[indexPath.row];
    return cell;
}

#pragma mark -UICollectionViewDelegateFlowLayout
//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = floor((kScreenWidth-16*2)/6);
    return CGSizeMake(width, width);
}

//间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 16, 10, 16);
}
//横向间距-上下
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
//纵向间距-左右
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(drawingBoardColor:)]) {
        [self.delegate drawingBoardColor:self.paintColor[indexPath.row]];
    }
    [self hiddenOnWindow];
}


- (void)showOnWindow{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.22 animations:^{
        
        self.collectionView.frame = CGRectMake(0, kScreenHeight-self.colorViewHeigt, kScreenWidth, self.colorViewHeigt);
    }];
}


- (void)hiddenOnWindow{
    
    [self hideFromWindowCompletedHandler:nil];
}

- (void)hideFromWindowCompletedHandler:(void(^)(void))completedHandler{
    
    [UIView animateWithDuration:.22 animations:^{
        
        self.collectionView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, self.colorViewHeigt);
        
    } completion:^(BOOL finished) {
        if (completedHandler) {
            completedHandler();
        }
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([touches.anyObject.view isDescendantOfView:self.collectionView]) {
        return;
    }else{
        
        [self hideFromWindowCompletedHandler:nil];
    }
    
}


@end
