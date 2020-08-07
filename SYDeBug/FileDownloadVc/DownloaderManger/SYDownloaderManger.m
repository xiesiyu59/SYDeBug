//
//  SYDownloaderManger.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/9.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SYDownloaderManger.h"
#import "SYDownLoader.h"

@interface SYDownloaderManger ()

// 创建一个下载操作的缓存池
@property(nonatomic,strong) NSMutableDictionary *downloadCache;

@end

@implementation SYDownloaderManger

static id instance;

-(NSMutableDictionary *)downloadCache{
    
    if (!_downloadCache) {
        _downloadCache = [[NSMutableDictionary alloc]init];
    }
    return _downloadCache;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

-(id)copy{
    
    return instance;
}

+(instancetype)shareDownloaderManger{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc]init];
    });
    
    return instance;
}

-(void)sy_downloadWithUrl:(NSURL *)url withDownProgress:(downProgress)progress completion:(downCompletion)completion fail:(downFailed)failed
{
    self.failed = failed;
    
    // 1.判断缓存池里面是否有同一个下载任务
    SYDownLoader *downLoader = self.downloadCache[url.path];
    
    if (downLoader != nil) {
        NSLog(@"已经在下载列表中，请不要重复下载");
        return;
    }
    
    // 2.创建新的下载任务
    downLoader = [[SYDownLoader alloc]init];

    // 3.将下载任务添加到缓存池
    [self.downloadCache setValue:downLoader forKey:url.path];
    
    __weak typeof(self) weakSelf = self;
    [downLoader sy_downloadWithUrl:url withDownProgress:progress completion:^(NSString * _Nonnull downFilePath) {
        // 1.将下载从缓存池移除
        [weakSelf.downloadCache removeObjectForKey:url.path];
        // 2.执行调用方法的回调
        if (completion) {
            
            completion(downFilePath);
        }
    } fail:failed];
    
}

#pragma mark 暂停某个文件下载
-(void)pauseloadWithUrl:(NSURL *)url{
    
    // 1.通过url获取下载任务
    SYDownLoader *downLoader = self.downloadCache[url.path];
    
    // 2.暂停下载
    if (downLoader == nil){
        
        if (self.failed) {
            
            self.failed(@"已经暂停下载，请不要重复点击");
        }
        return;
    }
    [downLoader pause];
    
    // 3.从缓存池移除
    [self.downloadCache removeObjectForKey:url.path];
    
}

@end
