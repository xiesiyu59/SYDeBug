//
//  StrConversion.h
//  TestESmartcup
//
//  Created by xiesiyu on 2017/10/26.
//  Copyright © 2017年 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrConversion : NSObject

//将NSString转换成十六进制的字符串
+ (NSString *)convertStringToHexString:(NSString *)string;

// 十六进制转换为普通字符串的。
+ (NSString *)convertHexStringToString:(NSString *)hexString;

//16进制字符串转Data
+ (NSData *)convertHexStringToData:(NSString *)HexString;

// Data转换为十六进制
+ (NSString *)convertDataToHexString:(NSData *)data;

//10进制转16进制
+ (NSString *)getHexByDecimal:(NSInteger)decimal;

@end
