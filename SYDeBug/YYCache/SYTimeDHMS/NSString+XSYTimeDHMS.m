//
//  NSString+XSYTimeDHMS.m
//  UrumqiMetro
//
//  Created by xiesiyu on 2019/5/8.
//  Copyright © 2019 xiesiyu. All rights reserved.
//
#import "NSString+XSYTimeDHMS.h"
#import "StrConversion.h"

@implementation NSString (XSYTimeDHMS)


/// 获取当前时间和预期时间的相差时间
/// @param timeString yyyy-MM-dd HH:mm:ss
+ (TimeDHMSModel *)getTwoTimeDifferences:(NSString *)timeString{
    
    //预期时间
    NSString *texpectedTime = [NSString stringTimeConversionTimestamp:timeString dateformater:@"yyyy-MM-dd HH:mm:ss"];
    //当前时间
    NSDate *nowTime = [NSDate date];
    NSString *nowTimeStr = [NSString currentTimeConversionStringTimestamp:nowTime];
    
    //时间差值
    NSInteger timeDifference = ABS([nowTimeStr integerValue] - [texpectedTime integerValue]);
    NSString *kDay = [NSString stringWithFormat:@"%ld", (long)((timeDifference)/60/60/24)];
    NSString *kHour = [NSString stringWithFormat:@"%ld", (long)((timeDifference)/60/60)];
    NSString *kMinute = [NSString stringWithFormat:@"%ld", (long)((timeDifference)/60)%60];
    NSString *kSecond = [NSString stringWithFormat:@"%ld", ((long)(timeDifference))%60];
    
    NSDictionary *timeDcit = @{@"timeDifference":@(timeDifference),
                               @"texpectedtime":texpectedTime,
                               @"nowtime":nowTimeStr,
                               @"day":kDay,
                               @"hour":kHour,
                               @"minute":kMinute,
                               @"sencond":kSecond};
    
    TimeDHMSModel *model = [[TimeDHMSModel alloc] initWithDictionary:timeDcit];
    return model;
}


/// 获取当前时间和预期时间的相差时间
/// @param timeString 时间戳
+ (TimeDHMSModel *)timeStampTwoTimeDifferences:(NSString *)timeString{
    
    //预期时间
    NSString *texpectedTime = timeString;
    //当前时间
    NSDate *nowTime = [NSDate date];
    NSString *nowTimeStr = [NSString currentTimeConversionStringTimestamp:nowTime];
    
    //时间差值
    NSInteger timeDifference = ABS([nowTimeStr integerValue] - [texpectedTime integerValue]);
    NSString *kDay = [NSString stringWithFormat:@"%ld", (long)((timeDifference)/60/60/24)];
    NSString *kHour = [NSString stringWithFormat:@"%ld", (long)((timeDifference)/60/60)];
    NSString *kMinute = [NSString stringWithFormat:@"%ld", (long)((timeDifference)/60)%60];
    NSString *kSecond = [NSString stringWithFormat:@"%ld", ((long)(timeDifference))%60];
    
    NSDictionary *timeDcit = @{@"timeDifference":@(timeDifference),
                               @"texpectedtime":texpectedTime,
                               @"nowtime":nowTimeStr,
                               @"day":kDay,
                               @"hour":kHour,
                               @"minute":kMinute,
                               @"sencond":kSecond};
    
    TimeDHMSModel *model = [[TimeDHMSModel alloc] initWithDictionary:timeDcit];
    return model;
}


/// 指定2个时间相差时间
/// @param currentTime 当前时间 yyyy-MM-dd HH:mm:ss | 时间戳
/// @param targetTime 结束时间 yyyy-MM-dd HH:mm:ss | 时间戳
/// @param timeStamp 是否是时间戳
+ (TimeDHMSModel *)currentTime:(NSString *)currentTime targetTime:(NSString *)targetTime isTimeStamp:(BOOL)timeStamp{
    
    NSString *texpectedTime;
    NSString *nowTimeStr;
    if (timeStamp) {
        texpectedTime = targetTime;
        //当前时间
        nowTimeStr = currentTime;
    }else{
        //预期时间
        texpectedTime = [NSString stringTimeConversionTimestamp:targetTime dateformater:@"yyyy-MM-dd HH:mm:ss"];
        //当前时间
        nowTimeStr = [NSString stringTimeConversionTimestamp:currentTime dateformater:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    //时间差值
    NSInteger timeDifference = ABS([nowTimeStr integerValue] - [texpectedTime integerValue]);
    NSString *kDay = [NSString stringWithFormat:@"%ld", (long)((timeDifference)/60/60/24)];
    NSString *kHour = [NSString stringWithFormat:@"%ld", (long)((timeDifference)/60/60)];
    NSString *kMinute = [NSString stringWithFormat:@"%ld", (long)((timeDifference)/60)%60];
    NSString *kSecond = [NSString stringWithFormat:@"%ld", ((long)(timeDifference))%60];
    
    NSDictionary *timeDcit = @{@"timeDifference":@(timeDifference),
                               @"texpectedtime":texpectedTime,
                               @"nowtime":nowTimeStr,
                               @"day":kDay,
                               @"hour":kHour,
                               @"minute":kMinute,
                               @"sencond":kSecond};
    
    TimeDHMSModel *model = [[TimeDHMSModel alloc] initWithDictionary:timeDcit];
    return model;
    
}


/// 获取月日小时分钟
/// @param timeStr yyyy-MM-dd HH:mm:ss
+ (NSString *)timeStringWithMMDD:(NSString *)timeStr{
    
    NSArray *temp = [timeStr componentsSeparatedByString:@" "];
    if (temp.count >= 1) {
        NSString *tempString = temp.firstObject;
        NSString *hmString = temp.lastObject;
        NSArray *tempArr = [tempString componentsSeparatedByString:@"-"];
        NSArray *hmArr = [hmString componentsSeparatedByString:@":"];
        if (tempArr.count > 2) {
            return [NSString stringWithFormat:@"%@月%@日 %@:%@",tempArr[1],tempArr[2],hmArr[0],hmArr[1]];
        }else{
            return tempString;
        }
    }else{
        return timeStr;
    }
}

///时间戳转字符串年月日返回年月日汉字
+ (NSString *)timeStringWithCYMD:(NSString *)timeStr{
    
    NSArray *temp = [timeStr componentsSeparatedByString:@" "];
    if (temp.count >= 1) {
        NSString *tempString = temp.firstObject;
        NSString *hmString = temp.lastObject;
        NSArray *tempArr = [tempString componentsSeparatedByString:@"-"];
        NSArray *hmArr = [hmString componentsSeparatedByString:@":"];
        if (tempArr.count > 2) {
            return [NSString stringWithFormat:@"%@年%@月%@日",tempArr[0],tempArr[1],tempArr[2]];
        }else{
            return tempString;
        }
    }else{
        return timeStr;
    }
}



///时间戳转字符串年月日返回小时分
+ (NSString *)timeStringWithCHM:(NSString *)timeStr{
    
    NSArray *temp = [timeStr componentsSeparatedByString:@" "];
    if (temp.count >= 1) {
        NSString *tempString = temp.firstObject;
        NSString *hmString = temp.lastObject;
        NSArray *tempArr = [tempString componentsSeparatedByString:@"-"];
        NSArray *hmArr = [hmString componentsSeparatedByString:@":"];
        if (tempArr.count > 2) {
            return [NSString stringWithFormat:@"%@:%@",hmArr[0],hmArr[1]];
        }else{
            return tempString;
        }
    }else{
        return timeStr;
    }
}


///当前时间转字符换时间戳
+ (NSString *)currentTimeConversionStringTimestamp:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval timestamp = [date timeIntervalSince1970];
    NSString *timestampString = [NSString stringWithFormat:@"%i", (int)timestamp];
    
    return timestampString;
}


/// 字符串时间转换时间戳
/// @param timeStr 字符串时间
/// @param dateformater yyyy-MM-dd HH:mm:ss 格式
+ (NSString *)stringTimeConversionTimestamp:(NSString *)timeStr dateformater:(NSString *)dateformater{
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:dateformater];
    NSDate *date = [formater dateFromString:timeStr];
    
    NSTimeInterval timestamp = [date timeIntervalSince1970];
    NSString *timestampString = [NSString stringWithFormat:@"%i", (int)timestamp];
    
    return timestampString;
}


/// 时间戳转字符串
/// @param timestamp 时间戳
/// @param dateformater yyyy-MM-dd HH:mm:ss
+ (NSString *)timestampConversionStringTime:(NSInteger)timestamp dateformater:(NSString *)dateformater{
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:dateformater];
    NSString *string = [dateFormat stringFromDate:confromTimesp];
    return string;
}



///获取当前年月日时间戳
+ (NSString *)getNowDateYMD{
    
    //当前时间
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeStr = [formatter stringFromDate:nowDate];
    
    //时间戳
    NSDate *date = [formatter dateFromString:timeStr];
    NSTimeInterval timestamp = [date timeIntervalSince1970];
    NSString *timestampString = [NSString stringWithFormat:@"%i", (int)timestamp];
    
    return timestampString;
}

///获取当前年月日时分秒时间戳
+ (NSString *)getNowDateYMDHMS{
    
    //当前时间
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeStr = [formatter stringFromDate:nowDate];
    
    //时间戳
    NSDate *date = [formatter dateFromString:timeStr];
    NSTimeInterval timestamp = [date timeIntervalSince1970];
    NSString *timestampString = [NSString stringWithFormat:@"%i", (int)timestamp];
    
    return timestampString;
}

///获取当前年月日
+ (NSString *)getDateYearMonthDay:(NSInteger )type{
    
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nowDate];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    switch (type) {
        case 0:{
            return [NSString stringWithFormat:@"%.2ld",year];
        }break;
        case 1:{
            return [NSString stringWithFormat:@"%.2ld",month];
        }break;
        case 2:{
            return [NSString stringWithFormat:@"%.2ld",day];
        }break;
        case 3:{
            return [NSString stringWithFormat:@"%.2ld-%.2ld",year,month];
        }break;
        default:break;
    }
    return @"";
}

///获取当前周次
+ (NSInteger)getweekDay{
    
    NSInteger weekPage = 0;
    NSDate *nowDate = [NSDate date];
    //指定日历的算法
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:nowDate];
    // 1 是周日，2是周一 3.以此类推
    NSNumber *weekNumber = @([comps weekday]);
    NSInteger weekInt = [weekNumber integerValue];
    switch (weekInt) {
            
        case 1:{weekPage = 0;}break;
        case 2:{weekPage = 1;}break;
        case 3:{weekPage = 2;}break;
        case 4:{weekPage = 3;}break;
        case 5:{weekPage = 4;}break;
        case 6:{weekPage = 5;}break;
        case 7:{weekPage = 6;}break;
    }
    return weekPage;
}


///获取随机数
+ (NSString *)getTimeNow {
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    date = [formatter stringFromDate:[NSDate date]];
    //取出个随机数
    int last = arc4random() % 10000;
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@-%i", date,last];
    return timeNow;
}


///获取16进制10位数时间倒序
+ (NSString *)hexTimeTen{
    
    NSString *retimeStr = [StrConversion getHexByDecimal:[[NSString getNowDateYMDHMS] integerValue]];
    NSMutableString *reverseString = [NSMutableString string];
    for(NSInteger i = retimeStr.length-2; i >= 0 ; i=i-2){
        
        NSString *temp = [retimeStr substringWithRange:NSMakeRange(i, 2)];
        [reverseString appendFormat:@"%@",temp];
    }
    return reverseString;
}

@end
