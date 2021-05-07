//
//  CollectionVc.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/7.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "CollectionVc.h"

@interface CollectionVc ()

@end

@implementation CollectionVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self addHeaderRefresh];
    [self networkRereshing];
    [self addFooterRefresh];
    
}

- (void)networkRereshing{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *array = @[];
        if (self.pageIndex == 3) {
            array = @[];
        }
        [self updateDataSource:array];
    });
    
}


#pragma mark - DZNEmptyDataSetDelegate
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    //刷新数据
    [self activityIndicatorViewBegin];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *array = @[@"",@"",@"",@""];
        if (self.pageIndex == 3) {
            array = @[];
        }
        [self updateDataSource:array];
    });
}



@end
