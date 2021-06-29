//
//  NSString+XCJson.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/9.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XCJson)

// NSDictionary 转 jsonString
+ (NSString *)convertNSDictionaryToJsonString:(NSDictionary *)json;

// jsonString 转 NSDictionary
+ (NSDictionary *)convertJsonStringToNSDictionary:(NSString *)jsonString;

@end
