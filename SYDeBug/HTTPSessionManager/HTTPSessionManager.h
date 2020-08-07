//
//  HTTPSessionManager.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/9.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "RespondModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^NetworkRequestCallBack)(RespondModel *responseModel);

@interface HTTPSessionManager : AFHTTPSessionManager

//单例
+ (instancetype)shareManager;

// GET、POST请求
- (NSURLSessionDataTask *)GET:(NSString *)urlString  parameters:( NSDictionary *)parameters callBack:(NetworkRequestCallBack)callBack;
- (NSURLSessionDataTask *)POST:(NSString *)urlString  parameters:( NSDictionary *)parameters callBack:(NetworkRequestCallBack)callBack;

/*上传单张图片*/
- (NSURLSessionDataTask *)uploadImgFile:(UIImage *)imageFile parameter:(NSDictionary*)parameter callBack:(NetworkRequestCallBack)callBack;
/*上传多张图片*/
- (NSURLSessionDataTask *)uploadImgFiles:(NSArray *)imageFiles parameter:(NSDictionary*)parameter callBack:(NetworkRequestCallBack)callBack;
/*上传视频*/
- (NSURLSessionDataTask *)uploadVideoFile:(NSArray *)videoFiles parameter:(NSDictionary*)parameter callBack:(NetworkRequestCallBack)callBack;


// 取消所有请求
- (void)cancelAllTasks;

@end

NS_ASSUME_NONNULL_END
