//
//  SYDrawingBoardToolView.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/12.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYDrawingBoardToolView.h"

@interface SYDrawingBoardToolView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)NSArray *titleArray;       ///标题

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation SYDrawingBoardToolView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleArray = @[@"清除",@"撤销",@"恢复",@"画笔颜色",@"橡皮擦",@"保/退"];
        self.backgroundColor = [UIColor whiteColor];
        [self initWithInitialization];
    }
    
    return self;
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    
    self.slider = [[UISlider alloc] init];
    self.slider.tintColor = [UIColor blackColor];
    [self.slider addTarget:self action:@selector(sliderValue:) forControlEvents:UIControlEventValueChanged];
    self.slider.minimumValue = 1;
    self.slider.maximumValue = 45;
    [self addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(24);
        make.right.equalTo(self.mas_right).offset(-24);
        make.top.equalTo(line.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
    UIView *Tline = [[UIView alloc]init];
    Tline.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:Tline];
    [Tline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.slider.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowlayout.itemSize = CGSizeMake((kScreenWidth-5)/self.titleArray.count, 40);
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.minimumLineSpacing = 1;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SYDrawingBoardToolItemCell class] forCellWithReuseIdentifier:SYDrawingBoardToolItemCell.className];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Tline.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SYDrawingBoardToolItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SYDrawingBoardToolItemCell.className forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    return cell;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didToolBtn:)]) {
        [self.delegate didToolBtn:indexPath];
    }
}


- (void)sliderValue:(UISlider *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(lineWidth:)]) {
        [self.delegate lineWidth:sender.value];
    }
}


@end


@implementation SYDrawingBoardToolItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initWithInitialization];
    }
    
    return self;
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


@end
