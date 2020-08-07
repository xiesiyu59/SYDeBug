//
//  FMDBManager.m
//  SYDeBug
//
//  Created by xiesiyu on 2019/11/13.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "FMDBManager.h"

static FMDBManager *instance = nil;

@implementation FMDBManager

#pragma mark - 单利 - 创建管理对象
+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FMDBManager alloc] init];
    });
    return instance;
}



- (void)initialization{
    
    self.db = [[FMDatabase alloc] init];
    //1.创建database路径
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"test.db"];
    NSLog(@"!!!dbPath = %@",dbPath);
    //2.创建对应路径下数据库
    self.db = [FMDatabase databaseWithPath:dbPath];
    //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
    [self.db open];
    if (![self.db open]) {
        NSLog(@"db open fail");
        return;
    }
    
}

- (void)addNewColumn{
    
    //ALTER TABLE Persons ADD Birthday date
    NSString *alertStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ INTEGER",@"t_student",@"brithday"];
    BOOL worked = [self.db executeUpdate:alertStr];
    if(worked){
        NSLog(@"插入字段成功");
    }else{
        NSLog(@"插入字段失败");
    }
}

- (void)editColumnName{
    
    //ALTER TABLE Persons ALTER COLUMN Birthday year
    NSString *alertStr = [NSString stringWithFormat:@"ALTER TABLE %@ RENAME COLUMN %@ TO %@",@"t_student",@"brithdayNew",@"brithday"];
    BOOL worked = [self.db executeUpdate:alertStr];
    if(worked){
        NSLog(@"修改字段类型成功");
    }else{
        NSLog(@"修改字段类型失败");
    }
}



@end
