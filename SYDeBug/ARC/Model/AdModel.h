//
//  AdModel.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/5/27.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdModel : NSObject

//category = 1;
//checkNum = 19912;
//content = "<p><br></p><p><img src=\"http://wlmq-metro-app.oss-cn-hangzhou.aliyuncs.com/xEnGCPtOaxXDpDDaAWpWgmRcSIdMj6c4KgGa9UqrMJ2zpX3nfl.gif\"></p><p><img src=\"http://wlmq-metro-app.oss-cn-hangzhou.aliyuncs.com/pfyq7Ilv4JjQBZQcFNFFDJtQDCyxU012EUQ3dDaIHkwAyHwQ8Z.gif\"></p><p><img src=\"http://wlmq-metro-app.oss-cn-hangzhou.aliyuncs.com/xYeia8OF4chYK1x4Ot412e86WbWjmNzkQVPJ7SFQDwArUNiUkn.gif\"></p>";
//createTime = "<null>";
//endTime = "2020-05-30 09:47:37";
//id = 61;
//imagePath = "http://wlmq-metro-app.oss-cn-hangzhou.aliyuncs.com/8vKU3UaVtzPsP249TBuOlWGWeqDc6tT8XNaHxN6UYGVaOF2jDL.jpg";
//showLocation = "<null>";
//smallProgramLink = "<null>";
//sort = 1;
//startTime = "2019-11-27 02:00:35";
//status = 0;
//title = "乌鲁木齐地铁二维码电子次票开售啦！";
//type = 1;


@property (nonatomic, strong)NSString *category;
@property (nonatomic, strong)NSString *checkNum;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *createTime;
@property (nonatomic, strong)NSString *idField;
@property (nonatomic, strong)NSString *showLocation;
@property (nonatomic, strong)NSString *smallProgramLink;
@property (nonatomic, strong)NSString *sort;
@property (nonatomic, strong)NSString *startTime;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *type;


@end

NS_ASSUME_NONNULL_END
