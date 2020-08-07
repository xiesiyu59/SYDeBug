//
//  CalendarDetailViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/17.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "CalendarDetailViewController.h"
#import <EventKit/EventKit.h>

@interface CalendarDetailViewController ()

@end

@implementation CalendarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithInitialization];
    
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    for (EKEvent *event in self.dataArray) {
        NSLog(@"%@",event.title);
    }
}


@end
