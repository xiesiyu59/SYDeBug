//
//  SYDownloadButton.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/8/7.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYColorLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYDownloadButton : UIView

@property (nonatomic, assign)BOOL isDownlod;
@property (nonatomic, strong)UIView *loadView;
@property (nonatomic, strong)SYColorLabel *titleLabel;
@property (nonatomic, assign)CGFloat present;

@end

NS_ASSUME_NONNULL_END
