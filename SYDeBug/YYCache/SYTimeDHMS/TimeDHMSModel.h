//
//  TimeDHMSModel.h
//  UrumqiMetro
//
//  Created by xiesiyu on 2019/5/8.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 timeDHMS -  D=day H=hour M=Minute S=Second
 */
@interface TimeDHMSModel : NSObject



/**
 
 NSDictionary *timeDcit = @{@"texpectedtime":texpectedTime,
 @"nowtime":nowTimeStr,
 @"day":kDay,
 @"hour":kHour,
 @"minute":kMinute,
 @"sencond":kSecond};
 */

@property (nonatomic, strong) NSString * timeTexpected;
@property (nonatomic, strong) NSString * timeNow;
@property (nonatomic, strong) NSString * timeDay;
@property (nonatomic, strong) NSString * timeHour;
@property (nonatomic, strong) NSString * timeMinute;
@property (nonatomic, strong) NSString * timeSecond;
@property (nonatomic, strong) NSString * timeDifference;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
