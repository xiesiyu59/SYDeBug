//
//  KeyChainTool.h
//  消汇邦
//
//  Created by xiesiyu on 2018/7/24.
//  Copyright © 2018年 深圳消汇邦成都分公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainTool : NSObject


/**
 防止恶意注册，新增设备UUID,判断设备注册次数

 */
+ (NSString *)UUID;

@end
