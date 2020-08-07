//
//  LabelView.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/5/27.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelViewModel.h"

#import "AdModel.h"
#import "MainModel.h"
#import "SpecialModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LabelView : UIView

@property (nonatomic, strong)LabelViewModel *model;

- (void)adArray:(NSArray <AdModel *>*)array;
- (void)mainArray:(NSArray <MainModel *>*)array;
- (void)specialArray:(NSArray <SpecialModel*>*)array;

@end

NS_ASSUME_NONNULL_END
