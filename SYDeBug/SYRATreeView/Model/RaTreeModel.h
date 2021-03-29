//
//  RaTreeModel.h
//  SYDeBug
//
//  Created by xiesiyu on 2021/3/29.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RaTreeModel : NSObject

@property (nonatomic,copy) NSString *name;//标题
@property (nonatomic,strong) NSArray *children;//子节点数组
@property (nonatomic,assign) BOOL isOpen; //是否打开
@property (nonatomic,assign) NSInteger treeDepthLevel; //树层级

 
//初始化一个model
- (id)initWithName:(NSString *)name children:(NSArray * )array;
 
//遍历构造器
+ (id)dataObjectWithName:(NSString *)name children:(NSArray *__nullable)children;

@end

NS_ASSUME_NONNULL_END
