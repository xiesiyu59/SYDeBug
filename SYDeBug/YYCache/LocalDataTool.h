//
//  LocalDataTool.h
//  Footstone
//
//  Created by xiesiyu on 2020/8/17.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalDataTool : NSObject

///本地地址 NSDocumentDirectory
+ (NSString *)cacheDocumentName:(NSString *)name;
///本地地址 NSLibraryDirectory
+ (NSString *)cacheLibarayName:(NSString *)name;
///本地地址 NSCachesDirectory
+ (NSString *)cacheCachesName:(NSString *)name;
///本地地址 tmp目录
+ (NSString *)cacheTmpName:(NSString *)name;

//本地是否存在文件
+ (BOOL)isCacheFilePath:(NSString *)filePath;


///plist根目录
+ (id)readDataPlistRoot;
///plist读取
+ (id)readDataPlistWithForKey:(NSString *)key;
///plist写入
+ (void)writeDataPlistValue:(id)value withForKey:(NSString *)key;
//plist删除
+ (void)removeDataPlist;

///YYCache读取
+ (id)readDataCacheWithForKey:(NSString *)key;
///YYCache写入
+ (void)writeDataCacheValue:(id)value withForKey:(NSString *)key;
///YYCache删除
+ (void)removeDataCacheWhiteForKey:(NSString *)key;


///NSUserDefaults读取
+ (id)readDataDefaultsWithForKey:(NSString *)key;
///NSUserDefaults写入
+ (void)writeDataDefaultsValue:(id)value withForKey:(NSString *)key;
///NSUserDefaults 删除
+ (void)removeDataDefaultsWhiteForKey:(NSString *)key;

///NSUserDefaults Bool 写入
+ (void)writeDataDefaultsBoolValue:(BOOL)value withForKey:(NSString *)key;
///NSUserDefaults Bool 读取
+ (BOOL)readDataDefaultsBoolWithForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
