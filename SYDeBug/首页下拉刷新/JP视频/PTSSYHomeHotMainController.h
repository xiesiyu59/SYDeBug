//
//  PTSSYHomeHotMainController.h
//  PetStore
//
//  Created by xiesiyu on 2020/6/3.
//  Copyright © 2020 Petstore. All rights reserved.
//

#import "BaseViewController.h"
#import "UITableView+WebVideoCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTSSYHomeHotMainController : BaseViewController

@property(nonatomic, assign, readonly) JPScrollPlayStrategyType scrollPlayStrategyType;

- (instancetype)initWithPlayStrategyType:(JPScrollPlayStrategyType)playStrategyType;

- (void)autoPlayer;
- (void)pause;
- (void)resume;

@property (nonatomic, assign)BOOL isCurrentVc;      //是否是当前vc

@end

NS_ASSUME_NONNULL_END
