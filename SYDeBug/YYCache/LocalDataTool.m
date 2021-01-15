//
//  LocalDataTool.m
//  Footstone
//
//  Created by xiesiyu on 2020/8/17.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "LocalDataTool.h"

//YYCache
#define SAVELOCATION_YYCache @"YYCacheLocalData"

//Plist
#define SAVELOCATION_PLIST @"LocalData.plist"


@interface LocalDataTool ()

@property (nonatomic, strong)YYCache *cache;

@end

static LocalDataTool *instance = nil;

@implementation LocalDataTool

#pragma mark - 单利 - 创建管理对象
+ (instancetype)manager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LocalDataTool alloc] init];
    });
    return instance;
}

///本地地址 NSDocumentDirectory
+ (NSString *)cacheDocumentName:(NSString *)name {
    
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [cacheFolder stringByAppendingPathComponent:name];
}

///本地地址 NSLibraryDirectory
+ (NSString *)cacheLibarayName:(NSString *)name {
    
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    return [cacheFolder stringByAppendingPathComponent:name];
}

///本地地址 NSCachesDirectory
+ (NSString *)cacheCachesName:(NSString *)name {
    
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [cacheFolder stringByAppendingPathComponent:name];
}

///本地地址 tmp目录
+ (NSString *)cacheTmpName:(NSString *)name {
    
    NSString *tmpPath = NSTemporaryDirectory();
    NSString *path =  [tmpPath stringByAppendingPathComponent:name];
    return  path;
}

//本地是否存在文件
+ (BOOL)isCacheFilePath:(NSString *)filePath{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return YES;
    }
    return NO;
}

///plist根目录
+ (id)readDataPlistRoot{
    
    NSDictionary *tempDict = [NSDictionary dictionaryWithContentsOfFile:[LocalDataTool cacheDocumentName:SAVELOCATION_PLIST]];
    return tempDict;
}

///plist读取
+ (id)readDataPlistWithForKey:(NSString *)key{
    
    NSDictionary *tempDict = [NSDictionary dictionaryWithContentsOfFile:[LocalDataTool cacheDocumentName:SAVELOCATION_PLIST]];
    return tempDict[key];
}

///plist写入
+ (void)writeDataPlistValue:(id)value withForKey:(NSString *)key{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if ([LocalDataTool readDataPlistRoot]) {
        dict = [LocalDataTool readDataPlistRoot];
    }
    [dict setObject:value forKey:key];
    [dict writeToFile:[LocalDataTool cacheDocumentName:SAVELOCATION_PLIST] atomically:YES];
}

//plist删除
+ (void)removeDataPlist{
    
    NSFileManager *fileMger = [NSFileManager defaultManager];
    NSString *filePath = [LocalDataTool cacheDocumentName:SAVELOCATION_PLIST];
    BOOL bRet = [fileMger fileExistsAtPath:filePath];
    if (bRet) {
        NSError *err;
        [fileMger removeItemAtPath:filePath error:&err];
    }
}


///YYCache读取
+ (id)readDataCacheWithForKey:(NSString *)key{
    
    [LocalDataTool manager].cache = [YYCache cacheWithPath:[LocalDataTool cacheDocumentName:SAVELOCATION_YYCache]];
    return [[LocalDataTool manager].cache objectForKey:key];
}

///YYCache写入
+ (void)writeDataCacheValue:(id)value withForKey:(NSString *)key{
    [LocalDataTool manager].cache = [YYCache cacheWithPath:[LocalDataTool cacheDocumentName:SAVELOCATION_YYCache]];
    [[LocalDataTool manager].cache setObject:value forKey:key];
}

///YYCache删除
+ (void)removeDataCacheWhiteForKey:(NSString *)key{
    
    [LocalDataTool manager].cache = [YYCache cacheWithPath:[LocalDataTool cacheDocumentName:SAVELOCATION_YYCache]];
    if (key.length) {
        [[LocalDataTool manager].cache removeObjectForKey:key];
    }else{
        [[LocalDataTool manager].cache removeAllObjects]; // 移除所有缓存
    }
}


///NSUserDefaults读取
+ (id)readDataDefaultsWithForKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * defaultsString = [defaults objectForKey:key];
    return defaultsString;
}

///NSUserDefaults写入
+ (void)writeDataDefaultsValue:(id)value withForKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

///NSUserDefaults 删除
+ (void)removeDataDefaultsWhiteForKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (key.length) {
        [defaults removeObjectForKey:key];
    }else{
        //移除所有
        NSString *appDomainStr = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomainStr];
    }
}


///NSUserDefaults Bool 写入
+ (void)writeDataDefaultsBoolValue:(BOOL)value withForKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    [defaults synchronize];
}

///NSUserDefaults Bool 读取
+ (BOOL)readDataDefaultsBoolWithForKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:key];
}



@end
