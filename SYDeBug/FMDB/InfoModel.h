//
//  InfoModel.h
//  SYDeBug
//
//  Created by xiesiyu on 2019/11/12.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoModel : NSObject

@property (nonatomic, copy)NSString     *userId;
@property (nonatomic, copy)NSString     *name;
@property (nonatomic, copy)NSString     *phone;
@property (nonatomic, copy)NSString     *score;         
@property (nonatomic, copy)NSString     *studentId;
@property (nonatomic, copy)NSString     *brithday;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)orderInfoWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
