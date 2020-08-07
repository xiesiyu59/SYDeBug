//
//  SpecialModel.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/5/27.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpecialModel : NSObject

//id = 6;
//imagePath = "http://wlmq-metro-app.oss-cn-hangzhou.aliyuncs.com/szZU13vSQlST4S5uijQSruAFbBw5F57AdxAYEQHUqb2s83Xejv.png";
//name = " ";
//title = " ";
//updateTime = "<null>";


@property (nonatomic, strong)NSString *idField;
@property (nonatomic, strong)NSString *imagePath;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *updateTime;

@end

NS_ASSUME_NONNULL_END
