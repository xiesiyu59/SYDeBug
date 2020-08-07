//
//  UIViewController+RoutePush.h
//
//  Created by 1244 on 2017/9/11.
//

#import <UIKit/UIKit.h>

@interface UIViewController (RoutePush)

- (BOOL)pushToViewControllerWithName:(NSString *)name param:(NSDictionary *)param;

@end
