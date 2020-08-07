//
//  CalendarViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/10.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "CalendarViewController.h"
#import <FSCalendar/FSCalendar.h>
#import <EventKit/EventKit.h>
#import "CalendarDetailViewController.h"
#import "NSDate+SYExtensions.h"

@interface CalendarViewController () <FSCalendarDelegate,FSCalendarDataSource>

@property (nonatomic, strong)FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *chineseCalendar;
@property (strong, nonatomic) NSArray<NSString *> *lunarChars;
@property (strong, nonatomic) NSArray<EKEvent *> *events;

@property (nonatomic, strong)NSDate *minimumDate;
@property (nonatomic, strong)NSDate *maximumDate;


@property(strong, nonatomic) NSCalendar *gregorianCalendar;

@end

@implementation CalendarViewController


- (NSArray<NSString *> *)lunarChars{
    if (!_lunarChars) {
        _lunarChars = [NSArray array];
    }
    return _lunarChars;
}

- (NSArray<EKEvent *> *)events{
    if (!_events) {
        _events = [NSArray array];
    }
    return _events;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithInitialization];
    [self initWithinitializationDataSource];
    
}


#pragma mark - <初始化数据源>
- (void)initWithinitializationDataSource {
    
    self.chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    self.gregorianCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
//    NSInteger lunarDay = [self.chineseCalendar component:NSCalendarUnitDay fromDate:[NSDate date]];
    self.lunarChars = @[@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"二一",@"二二",@"二三",@"二四",@"二五",@"二六",@"二七",@"二八",@"二九",@"三十"];
//    NSString *lunarDayString = self.lunarChars[lunarDay-1];
//    NSLog(@"%@",lunarDayString);
    
    self.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-3600*24*365];
    if ([self bissextile:[NSDate year:[NSDate currentDay]]]) {
        self.maximumDate = [NSDate dateWithTimeIntervalSinceNow:3600*24*366];
    }else{
        self.maximumDate = [NSDate dateWithTimeIntervalSinceNow:3600*24*365];
    }
    
    __weak typeof(self) weakSelf = self;
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if(granted) {
            NSDate *startDate = self.minimumDate; // 开始日期
            NSDate *endDate = self.maximumDate; // 截止日期
            NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
            NSArray<EKEvent *> *eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
            NSArray<EKEvent *> *events = [eventList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable event, NSDictionary<NSString *,id> * _Nullable bindings) {
                return event.calendar.subscribed;
            }]];
            weakSelf.events = events;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.calendar reloadData];
            });
            
        }
    }];
    
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    self.calendar = [[FSCalendar alloc] init];
    self.calendar.dataSource = self;
    self.calendar.delegate = self;
    self.calendar.appearance.headerDateFormat = @"yyyy年MM月";
    self.calendar.appearance.headerMinimumDissolvedAlpha = 0;   //隐藏年月日左右显示
    
    self.calendar.appearance.weekdayTextColor = [UIColor blackColor];   //周颜色
    self.calendar.appearance.headerTitleColor = [UIColor blackColor];  //头部字体颜色
    
//    self.calendar.appearance.borderRadius = 0;                  //正方形单元格
    [self.calendar selectDate:[NSDate date]];                   //默认日期
    self.calendar.appearance.todayColor = [UIColor blueColor];  //当天颜色
    self.calendar.appearance.selectionColor = [UIColor redColor]; //选中颜色
    
    self.calendar.scope = FSCalendarScopeMonth;
    
    [self.view addSubview:self.calendar];
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
    
    
}

-(void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    
    NSLog(@"%@",date);
    CalendarDetailViewController *vc = [[CalendarDetailViewController alloc] init];
    vc.dataArray = [self eventsForDate:date];
    if (![[self eventsForDate:date] count]) {
        return;
    }
    [self.navigationController pushViewController:vc animated:YES];
}


//日历
- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date {
    EKEvent *event = [self eventsForDate:date].firstObject;
    if (event) {
        return event.title; // 春分、秋分、儿童节、植树节、国庆节、圣诞节...
    }
    NSInteger day = [self.chineseCalendar component:NSCalendarUnitDay fromDate:date];
    return self.lunarChars[day-1]; // 初一、初二、初三...
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date {
    
    if ([self.gregorianCalendar isDateInToday:date]) {
        return @"今天";
    }
    return nil;
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date {
    
    NSArray<EKEvent *> *events = [self eventsForDate:date];
    return events.count;
}

// 某个日期的所有事件
- (NSArray<EKEvent *> *)eventsForDate:(NSDate *)date {
    
    NSArray<EKEvent *> *filteredEvents = [self.events filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.occurrenceDate isEqualToDate:date];
    }]];
    return filteredEvents;
}

- (BOOL)bissextile:(NSInteger)year {
     if ((year%4==0 && year %100 !=0) || year%400==0) {
            return YES;
     }else {
           return NO;
     }
     return NO;
}

@end
