//
//  NSString+XSYTimeDHMS.h
//  UrumqiMetro
//
//  Created by xiesiyu on 2019/5/8.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeDHMSModel.h"


@interface NSString (XSYTimeDHMS)


/// 获取当前时间和预期时间的相差时间
/// @param timeString yyyy-MM-dd HH:mm:ss
+ (TimeDHMSModel *)getTwoTimeDifferences:(NSString *)timeString;


/// 获取当前时间和预期时间的相差时间
/// @param timeString 时间戳
+ (TimeDHMSModel *)timeStampTwoTimeDifferences:(NSString *)timeString;


/// 指定2个时间相差时间
/// @param currentTime 当前时间 yyyy-MM-dd HH:mm:ss | 时间戳
/// @param targetTime 结束时间 yyyy-MM-dd HH:mm:ss | 时间戳
/// @param timeStamp 是否是时间戳
+ (TimeDHMSModel *)currentTime:(NSString *)currentTime targetTime:(NSString *)targetTime isTimeStamp:(BOOL)timeStamp;

/// 获取月日小时分钟
/// @param timeStr yyyy-MM-dd HH:mm:ss
+ (NSString *)timeStringWithMMDD:(NSString *)timeStr;

///时间戳转字符串年月日返回年月日汉字
+ (NSString *)timeStringWithCYMD:(NSString *)timeStr;


///时间戳转字符串年月日返回小时分
+ (NSString *)timeStringWithCHM:(NSString *)timeStr;


///当前时间转字符换时间戳
+ (NSString *)currentTimeConversionStringTimestamp:(NSDate *)date;

/// 字符串时间转换时间戳
/// @param timeStr 字符串时间
/// @param dateformater yyyy-MM-dd HH:mm:ss 格式
+ (NSString *)stringTimeConversionTimestamp:(NSString *)timeStr dateformater:(NSString *)dateformater;


/// 时间戳转字符串
/// @param timestamp 时间戳
/// @param dateformater yyyy-MM-dd HH:mm:ss
+ (NSString *)timestampConversionStringTime:(NSInteger)timestamp dateformater:(NSString *)dateformater;


///获取当前年月日时间戳
+ (NSString *)getNowDateYMD;
///获取当前年月日时分秒时间戳
+ (NSString *)getNowDateYMDHMS;
///获取当前年月日
+ (NSString *)getDateYearMonthDay:(NSInteger )type;

///获取当前周次
+ (NSInteger)getweekDay;

///获取随机数
+ (NSString *)getTimeNow;

///获取16进制10位数时间倒序
+ (NSString *)hexTimeTen;

@end
