//
//  InfoModel.m
//  SYDeBug
//
//  Created by xiesiyu on 2019/11/12.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        
        self.userId = dict[@"id"];
        self.name = dict[@"name"];
        self.phone = dict[@"phone"];
        self.score = dict[@"score"];
        self.studentId = dict[@"studentId"];
        self.brithday = dict[@"brithday"];
        
    }
    return self;
}

+ (instancetype)orderInfoWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}


@end
