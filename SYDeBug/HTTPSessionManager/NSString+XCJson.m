//
//  NSString+XCJson.m
//  消汇邦
//
//  Created by 1244 on 2017/9/12.
//  Copyright © 2017年 深圳消汇邦成都分公司. All rights reserved.
//

#import "NSString+XCJson.h"

@implementation NSString (XCJson)

// NSDictionary 转 jsonString
+ (NSString *)convertNSDictionaryToJsonString:(NSDictionary *)json {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"json解析失败:%@", error);
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

// jsonString 转 NSDictionary
+ (NSDictionary *)convertJsonStringToNSDictionary:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"jsonString解析失败:%@", error);
        return nil;
    }
    return json;
}


@end
