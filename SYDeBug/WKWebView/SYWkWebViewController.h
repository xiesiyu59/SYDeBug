//
//  SYWkWebViewController.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/3/4.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYWkWebViewController : BaseViewController

@property (nonatomic, copy) NSString     *urlString;
@property (nonatomic, copy) NSString     *contentString;

- (void)webRefresh;

@end

NS_ASSUME_NONNULL_END
