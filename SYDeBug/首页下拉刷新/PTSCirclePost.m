//
//  PTSCirclePost.m
//  PetStore
//
//  Created by Sarkizz on 2020/1/22.
//  Copyright © 2020 petstore. All rights reserved.
//

#import "PTSCirclePost.h"
#import "PTSCircleInfo.h"
#import "PTSCircleTopic.h"

@implementation PTSCirclePost

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"topics":[PTSCircleTopic class],@"user":[PTSUserInfo class]};
}

@end


@implementation PTSCirclePostDraft

+(NSDictionary *)bg_objectClassInArray{
    return @{@"selectedCircles":[PTSCircleInfo class],@"selectedTopics":[PTSCircleTopic class]};
}

- (void)deleteSelf {
    if (self.type == 2) {
        [[NSFileManager defaultManager] removeItemAtPath:self.video error:nil];
    }
    if (self.selectedTopics.count) {
        [self.selectedTopics enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [obj deleteSelf];
        }];
    }
    if (self.selectedCircles.count) {
        [self.selectedCircles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [obj deleteSelf];
        }];
    }
    [super deleteSelf];
}

@end


@implementation NSObject (bg_delete)

- (void)deleteSelf {
    
    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"bg_id"),bg_sqlValue(self.bg_id)];
    [PTSCirclePostDraft bg_delete:nil where:where];
}

@end
