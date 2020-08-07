//
//  TableView.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/7/13.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "TableView.h"

@implementation TableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame
                          style:style];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.separatorColor = [UIColor blackColor];
        self.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
        self.showsVerticalScrollIndicator = NO;
        
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            
        }
    }
    return self;
}

@end
