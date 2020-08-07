//
//  TimeDHMSModel.m
//  UrumqiMetro
//
//  Created by xiesiyu on 2019/5/8.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "TimeDHMSModel.h"


/**
 NSDictionary *timeDcit = @{@"texpectedtime":texpectedTime,
 @"nowtime":nowTimeStr,
 @"day":kDay,
 @"hour":kHour,
 @"minute":kMinute,
 @"sencond":kSecond};
 */

NSString *const kTimeDHMSTexpected = @"texpectedtime";
NSString *const kTimeDHMSNow = @"nowtime";
NSString *const kTimeDHMSDay = @"day";
NSString *const kTimeDHMSHour = @"hour";
NSString *const kTimeDHMSMinute = @"minute";
NSString *const kTimeDHMSSencond = @"sencond";
NSString *const kTimeDHMSDifference = @"timeDifference";



@interface TimeDHMSModel ()

@end

@implementation TimeDHMSModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kTimeDHMSTexpected] isKindOfClass:[NSNull class]]){
        self.timeTexpected = dictionary[kTimeDHMSTexpected];
    }
    if(![dictionary[kTimeDHMSNow] isKindOfClass:[NSNull class]]){
        self.timeNow = dictionary[kTimeDHMSNow];
    }
    if(![dictionary[kTimeDHMSDay] isKindOfClass:[NSNull class]]){
        self.timeDay = dictionary[kTimeDHMSDay];
    }
    if(![dictionary[kTimeDHMSHour] isKindOfClass:[NSNull class]]){
        self.timeHour = dictionary[kTimeDHMSHour];
    }
    if(![dictionary[kTimeDHMSMinute] isKindOfClass:[NSNull class]]){
        self.timeMinute = dictionary[kTimeDHMSMinute];
    }
    if(![dictionary[kTimeDHMSSencond] isKindOfClass:[NSNull class]]){
        self.timeSecond = dictionary[kTimeDHMSSencond];
    }
    if(![dictionary[kTimeDHMSDifference] isKindOfClass:[NSNull class]]){
        self.timeDifference = dictionary[kTimeDHMSDifference];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.timeTexpected != nil){
        dictionary[kTimeDHMSTexpected] = self.timeTexpected;
    }
    if(self.timeNow != nil){
        dictionary[kTimeDHMSNow] = self.timeNow;
    }
    if(self.timeDay != nil){
        dictionary[kTimeDHMSDay] = self.timeDay;
    }
    if(self.timeHour != nil){
        dictionary[kTimeDHMSHour] = self.timeHour;
    }
    if(self.timeMinute != nil){
        dictionary[kTimeDHMSMinute] = self.timeMinute;
    }
    if(self.timeSecond != nil){
        dictionary[kTimeDHMSSencond] = self.timeSecond;
    }
    if(self.timeDifference != nil){
        dictionary[kTimeDHMSDifference] = self.timeDifference;
    }
    
    return dictionary;
    
}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    
    if(self.timeTexpected != nil){
        [aCoder encodeObject:self.timeTexpected forKey:kTimeDHMSTexpected];
    }
    if(self.timeNow != nil){
        [aCoder encodeObject:self.timeNow forKey:kTimeDHMSNow];
    }
    if(self.timeDay != nil){
        [aCoder encodeObject:self.timeDay forKey:kTimeDHMSDay];
    }
    if(self.timeHour != nil){
        [aCoder encodeObject:self.timeHour forKey:kTimeDHMSHour];
    }
    if(self.timeMinute != nil){
        [aCoder encodeObject:self.timeMinute forKey:kTimeDHMSMinute];
    }
    if(self.timeSecond != nil){
        [aCoder encodeObject:self.timeSecond forKey:kTimeDHMSSencond];
    }
    if(self.timeDifference != nil){
        [aCoder encodeObject:self.timeDifference forKey:kTimeDHMSDifference];
    }
    
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.timeTexpected = [aDecoder decodeObjectForKey:kTimeDHMSTexpected];
    self.timeNow = [aDecoder decodeObjectForKey:kTimeDHMSNow];
    self.timeDay = [aDecoder decodeObjectForKey:kTimeDHMSDay];
    self.timeHour = [aDecoder decodeObjectForKey:kTimeDHMSHour];
    self.timeMinute = [aDecoder decodeObjectForKey:kTimeDHMSMinute];
    self.timeSecond = [aDecoder decodeObjectForKey:kTimeDHMSSencond];
    self.timeDifference = [aDecoder decodeObjectForKey:kTimeDHMSDifference];
    
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    TimeDHMSModel *copy = [TimeDHMSModel new];
    
    copy.timeTexpected = [self.timeTexpected copy];
    copy.timeNow = [self.timeNow copy];
    copy.timeDay = [self.timeDay copy];
    copy.timeHour = [self.timeHour copy];
    copy.timeMinute = [self.timeMinute copy];
    copy.timeSecond = [self.timeSecond copy];
    copy.timeDifference = [self.timeDifference copy];
    return copy;
}

@end
