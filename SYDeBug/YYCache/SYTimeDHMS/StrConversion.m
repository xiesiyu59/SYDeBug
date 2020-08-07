//
//  StrConversion.m
//  TestESmartcup
//
//  Created by xiesiyu on 2017/10/26.
//  Copyright © 2017年 xiesiyu. All rights reserved.
//

#import "StrConversion.h"

@implementation StrConversion


//将NSString转换成十六进制的字符串
+ (NSString *)convertStringToHexString:(NSString *)string {
    if (!string || [string length] == 0) {
        return @"";
    }
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableString *mutableString = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                
                [mutableString appendString:hexStr];
                
            } else {
                
                [mutableString appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return mutableString;
}


// 十六进制转换为普通字符串的。
+ (NSString *)convertHexStringToString:(NSString *)hexString {
    
    if (!hexString || [hexString length] == 0) {
        
        return @"";
    }
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString;
}

//16进制字符串转Data
+ (NSData *)convertHexStringToData:(NSString *)HexString {
    
    if (!HexString || [HexString length] == 0) {
        
        return  nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    
    if ([HexString length] % 2 == 0) {
        
        range = NSMakeRange(0, 2);
        
    }else{
        
        range = NSMakeRange(0, 1);
    }
    
    for (NSInteger i = range.location; i < [HexString length]; i +=2) {
        
        unsigned int anInt;
        NSString *hexCharStr = [HexString substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
        
    }
    
    return hexData;
}


// 普通字符串转换为十六进
+ (NSString *)convertDataToHexString:(NSData *)data {
    
    Byte *bytes = (Byte *)[data bytes];
    // 下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for(int i=0; i<[data length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i] & 0xff]; //16进制数
        newHexStr = [newHexStr uppercaseString];
        
        if([newHexStr length] == 1) {
            newHexStr = [NSString stringWithFormat:@"0%@",newHexStr];
        }
        
        hexStr = [hexStr stringByAppendingString:newHexStr];
        
    }
    return hexStr;
}

+ (NSString *)getHexByDecimal:(NSInteger)decimal {
    
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            
            break;
        }
    }
    return hex;
}
@end
