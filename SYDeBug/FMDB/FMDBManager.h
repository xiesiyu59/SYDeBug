//
//  FMDBManager.h
//  SYDeBug
//
//  Created by xiesiyu on 2019/11/13.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMDBManager : NSObject

// 单利
+ (instancetype)shareManager;

@property (nonatomic, strong)FMDatabase *db;



- (void)initialization;

//增加一个新列
- (void)addNewColumn;
//修改字段名称
- (void)editColumnName;

@end

NS_ASSUME_NONNULL_END
