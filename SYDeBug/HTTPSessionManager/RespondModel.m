//
//  RespondModel.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/9.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "RespondModel.h"

NSString *const kRespondCode = @"code";
NSString *const kRespondData = @"result";
NSString *const kRespondDesc = @"msg";
NSString *const kRespondTime = @"time";

@implementation RespondModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kRespondCode] isKindOfClass:[NSNull class]]){
        self.code = [dictionary[kRespondCode] integerValue];
    }
    if(![dictionary[kRespondData] isKindOfClass:[NSNull class]]){
        self.data = dictionary[kRespondData];
    }
    if(![dictionary[kRespondDesc] isKindOfClass:[NSNull class]]){
        self.msg = dictionary[kRespondDesc];
    }
    if(![dictionary[kRespondTime] isKindOfClass:[NSNull class]]){
        self.time = dictionary[kRespondTime];
    }
    
    return self;
}

@end

//列表模型
@implementation ListPage
@end

@implementation ListData
@end

@implementation ListModel
@end
