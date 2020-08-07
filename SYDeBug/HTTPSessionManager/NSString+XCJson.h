//
//  NSString+XCJson.h
//  消汇邦
//
//  Created by 1244 on 2017/9/12.
//  Copyright © 2017年 深圳消汇邦成都分公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XCJson)

// NSDictionary 转 jsonString
+ (NSString *)convertNSDictionaryToJsonString:(NSDictionary *)json;

// jsonString 转 NSDictionary
+ (NSDictionary *)convertJsonStringToNSDictionary:(NSString *)jsonString;

@end
