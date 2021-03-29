//
//  RaTreeModel.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/3/29.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "RaTreeModel.h"

@implementation RaTreeModel


- (id)initWithName:(NSString *)name children:(NSArray *)children {
    
    self = [super init];
    if (self) {
        self.children = children;
        self.name = name;
    }
    return self;
}
 
+ (id)dataObjectWithName:(NSString *)name children:(NSArray *__nullable)children {
    
    return [[self alloc] initWithName:name children:children];

}
@end
