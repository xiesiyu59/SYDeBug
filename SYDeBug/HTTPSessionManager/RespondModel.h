//
//  RespondModel.h
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/9.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RespondCode) {
    
    RequestTimeout          = -1001,    ///AFN请求超时错误
    RequestUnreachable      = -1004,    ///AFN请求不可达错误
    RespondCodeError        = 501,      ///请求失败
    RespondCodeSuccess      = 200,      ///请求成功
    RespondCodeUnauthorized = 801,      ///请求超时
    RespondCodeNotJson      = 3840,     ///非Json数据
    
};


@interface RespondModel : NSObject

@property (nonatomic, assign) RespondCode code;     //请求code号
@property (nonatomic, copy  ) NSString  *msg;       //请求信息
@property (nonatomic, copy  ) NSString  *time;      //时间
@property (nonatomic, strong) id        data;       //请求数据

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

//列表模型
@interface ListPage : NSObject

@property (nonatomic, assign) NSInteger total;              //总数
@property (nonatomic, assign) NSInteger current_page;       //当前页数
@property (nonatomic, assign) NSInteger per_page;           //每页多少个
@property (nonatomic, assign) NSInteger last_page;          //总页数

@end

@interface ListData : NSObject
@property (nonatomic, strong) NSArray * list;               //列表数据
@property (nonatomic, strong) ListPage * page;              //页数信息
@end

@interface ListModel : NSObject
@property (nonatomic, assign) NSInteger code;               //请求号
@property (nonatomic, strong) ListData * data;              //数组模型
@property (nonatomic, strong) NSString * msg;               //请求信息
@end

NS_ASSUME_NONNULL_END
