//
//  SYDownloaderManger.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/9.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 下载成功的 block 返回下载后的文件路径
typedef void(^downCompletion)(NSString * _Nonnull downFilePath);
// 下载进度的 block 返回进度值
typedef void(^downProgress)(float progress);
// 下载失败的 block 返回下载失败的信息
typedef void(^downFailed)(NSString * _Nullable error);

@interface SYDownloaderManger : NSObject

@property(nonatomic,strong) downFailed failed;


+(instancetype)shareDownloaderManger;

#pragma mark 定义一个下载的方法
/**
 定义一个下载的方法
 
 @param url 下载的地址 url
 */
-(void)sy_downloadWithUrl:(NSURL *)url withDownProgress:(downProgress)progress completion:(downCompletion)completion fail:(downFailed)failed;

#pragma mark 暂停某个文件下载
-(void)pauseloadWithUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
