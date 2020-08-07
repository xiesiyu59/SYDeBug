//
//  HTTPSessionManager.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/9.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "HTTPSessionManager.h"
#import "NSString+XCJson.h"

@implementation HTTPSessionManager


static dispatch_once_t onceToken;
static HTTPSessionManager *manager;

#pragma mark -
+ (instancetype)shareManager {
    dispatch_once(&onceToken, ^{
        
        manager = [[HTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"https://metro.0991777.com/"]]];
    });
    
    manager.requestSerializer.timeoutInterval         = 15;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", @"text/html",@"text/json", @"text/plain",nil];
    //上传Token
//    NSString *token = [NSString stringWithFormat:@"Bearer %@",[LocalDataTool readToken]];
//    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"sys_type"];
    NSString *version                                 = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:version ? version : @"" forHTTPHeaderField:@"app_version"];
    return manager;
}

- (NSURLSessionDataTask *)GET:(NSString *)urlString
                   parameters:(NSDictionary *)parameters
                     callBack:(NetworkRequestCallBack)callBack {
    
    
    return [self GET:urlString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"✅%@\n%@\n%@",urlString,parameters,responseObject);
        [self handleRespond:responseObject
                      error:nil
                   callBack:callBack];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
        NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSString convertJsonStringToNSDictionary:errorStr];
        [self handleRespond:dict
                      error:error
                   callBack:callBack];
        NSLog(@"❌%@\n%@\n%@",urlString,parameters,error);
    }];
    
}


- (NSURLSessionDataTask *)POST:(NSString *)urlString
                    parameters:(NSDictionary *)parameters
                      callBack:(NetworkRequestCallBack)callBack {
    
    return [self POST:urlString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"✅%@\n%@\n%@",urlString,parameters,responseObject);
        [self handleRespond:responseObject
                      error:nil
                   callBack:callBack];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSString convertJsonStringToNSDictionary:errorStr];
        NSLog(@"❌%@\n%@\n%@",urlString,parameters,error);
        [self handleRespond:dict
                      error:error
                   callBack:callBack];
    }];
}


- (NSURLSessionDataTask *)uploadImgFile:(UIImage *)imageFile parameter:(NSDictionary*)parameter callBack:(NetworkRequestCallBack)callBack {
    
    return [self POST:@"" parameters:parameter headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = [self imageZipToData:imageFile];
        NSString *fileStr = [NSString stringWithFormat:@"%@.png",[self getTimeNow]];
        [formData appendPartWithFileData:data name:@"file" fileName:fileStr mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"✅%@\n%@",parameter,responseObject);
        [self handleRespond:responseObject error:nil callBack:callBack];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSString convertJsonStringToNSDictionary:errorStr];
        NSLog(@"❌%@\n%@\n%@",dict,error,error);
        [self handleRespond:dict error:error callBack:callBack];
    }];
    
}

- (NSURLSessionDataTask *)uploadImgFiles:(NSArray *)imageFiles parameter:(NSDictionary*)parameter callBack:(NetworkRequestCallBack)callBack {
    
    return [self POST:@"" parameters:parameter headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (!imageFiles) {
            return ;
        }
        // 上传 多张图片
        for (NSInteger i = 0; i < imageFiles.count; i ++) {
            UIImage * eachImg = imageFiles[i];
            NSData *data = [self imageZipToData:eachImg];
            NSString *fileStr = [NSString stringWithFormat:@"%@_image_%ld.png",[self getTimeNow],(long)i];
            [formData appendPartWithFileData:data
                                        name:[NSString stringWithFormat:@"file"]
                                    fileName:fileStr
                                    mimeType:@"image/png"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"✅%@\n%@",parameter,responseObject);
        [self handleRespond:parameter error:nil callBack:callBack];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSString convertJsonStringToNSDictionary:errorStr];
        NSLog(@"❌%@\n%@\n%@",dict,error,error);
        
        [self handleRespond:dict error:error callBack:callBack];
    }];
    
}

/*上传视频*/
- (NSURLSessionDataTask *)uploadVideoFile:(NSArray *)videoFiles parameter:(NSDictionary*)parameter callBack:(NetworkRequestCallBack)callBack{
    
    return [self POST:@"" parameters:parameter headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (!videoFiles) {
            return ;
        }
        //上传视频
        for (NSInteger i = 0; i < videoFiles.count; i ++) {
            NSString * videoUrl = videoFiles[i];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:videoUrl]];
            NSString *fileStr = [NSString stringWithFormat:@"%@_video_%ld.mp4",[self getTimeNow],(long)i];
            [formData appendPartWithFileData:data
                                        name:[NSString stringWithFormat:@"videoFile"]
                                    fileName:fileStr
                                    mimeType:@"video/*"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"✅%@\n%@",parameter,responseObject);
        [self handleRespond:parameter error:nil callBack:callBack];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *errorStr = [[ NSString alloc ] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSString convertJsonStringToNSDictionary:errorStr];
        NSLog(@"❌%@\n%@\n%@",dict,error,error);
        [self handleRespond:dict error:error callBack:callBack];
    }];
}


/**
 处理网络请求的成功和失败
 
 @param responseObject 相应的数据
 @param error 错误，可为空
 @param callBack 返回RespondModel
 */
- (void)handleRespond:(id)responseObject error:(NSError *)error callBack:(NetworkRequestCallBack)callBack{
    if (!error) {
        
        RespondModel *model = [[RespondModel alloc]initWithDictionary:responseObject];
        //处理验证失败
        if (model.code == RespondCodeUnauthorized) {
            NSLog(@"请求超时");
        }else{
            callBack(model);
        }
        
    }else{
        
        RespondModel *model = [[RespondModel alloc]initWithDictionary:responseObject];
        if (error.code == RespondCodeNotJson) {
            model.code          = RespondCodeNotJson;
            model.msg          = @"服务器开小差,请稍后再试";
        }else if (error.code == RequestTimeout){
            model.code          = RequestTimeout;
            model.msg          = @"请求超时,请重试";
        }else if (error.code == RequestUnreachable){
            model.code          = RequestUnreachable;
            model.msg           = model.msg;
        }else{
            model.code          = RespondCodeError;
            model.msg           = @"网络好像出错啦";
        }
        callBack(model);
    }
    
}


#pragma mark -
- (void)cancelAllTasks {
    [self.tasks makeObjectsPerformSelector:@selector(cancel)];
}

//转成data
- (NSData *)imageZipToData:(UIImage *)newImage{
    
    NSData *data = UIImageJPEGRepresentation(newImage, 1.0);
    
    if (data.length > 500 * 1024) {
        
        if (data.length>1024 * 1024) {//1M以及以上
            
            data = UIImageJPEGRepresentation(newImage, 0.5);
            
        }else if (data.length>512*1024) {//0.5M-1M
            
            data=UIImageJPEGRepresentation(newImage, 0.6);
            
        }else if (data.length>200*1024) { //0.25M-0.5M
            
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}

//获取随机数
- (NSString *)getTimeNow {
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    date = [formatter stringFromDate:[NSDate date]];
    //取出个随机数
    int last = arc4random() % 10000;
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@-%i", date,last];
    return timeNow;
}

@end
