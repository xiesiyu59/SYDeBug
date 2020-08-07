//
//  MainModel.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/5/27.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainModel : NSObject

//address = "";
//collectNo = "<null>";
//collectStatus = "<null>";
//content = "<h1>时刻表</h1><p><img src=\"http://wlmq-metro-app.oss-cn-hangzhou.aliyuncs.com/BfhHnBmxqsdoIaFBOTDbXieSKcip46hmPj4dm7QoQuDhnVMAtm.png\"></p><h1>票价表</h1><p><img src=\"http://wlmq-metro-app.oss-cn-hangzhou.aliyuncs.com/y6TNgd9AtadPQt8ypo9K1nQt1vUJOHmmwFl7VWdI2BLctCEGri.jpg\"></p>";
//createTime = "2020-05-19 23:37:54";
//del = "<null>";
//endTime = "2020-12-31 23:35:33";
//id = 44;
//imagePath = "http://wlmq-metro-app.oss-cn-hangzhou.aliyuncs.com/ioYlHIuOownIQSJdd661XY4aIIN5J5sMTKKFtGdrfymHD7Bf7r.jpg";
//lat = "";
//line = "";
//lon = "";
//shareNo = "<null>";
//shopName = "";
//sort = 0;
//standName = "";
//startTime = "2020-05-19 23:35:33";
//title = "乌鲁木齐地铁时刻表 票价表";
//type = 1;


@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *collectNo;
@property (nonatomic, strong)NSString *collectStatus;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *createTime;
@property (nonatomic, strong)NSString *del;
@property (nonatomic, strong)NSString *endTime;
@property (nonatomic, strong)NSString *idField;
@property (nonatomic, strong)NSString *imagePath;
@property (nonatomic, strong)NSString *lat;
@property (nonatomic, strong)NSString *line;
@property (nonatomic, strong)NSString *lon;
@property (nonatomic, strong)NSString *shareNo;
@property (nonatomic, strong)NSString *shopName;
@property (nonatomic, strong)NSString *sort;
@property (nonatomic, strong)NSString *standName;
@property (nonatomic, strong)NSString *startTime;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *type;


@end

NS_ASSUME_NONNULL_END
