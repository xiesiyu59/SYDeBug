//
//  UIViewController+RoutePush.h
//
//  Created by 1244 on 2017/9/11.
//

#import "UIViewController+RoutePush.h"
#import "BaseViewController.h"

@implementation UIViewController (RoutePush)

- (BOOL)pushToViewControllerWithName:(NSString *)name param:(NSDictionary *)param{
    if (name.length == 0) {
        return NO;
    }
    
//#ifdef DEBUG
//    if ([name isEqualToString:@"PPCounterViewController"]) {
//          name = @"PPCounterViewController";
//    }
//    
//#endif
    
    if ([name isEqualToString:@"openSafari"]) {
        [self openInSafari:[NSURL URLWithString:param[@"urlString"]]];
    }
    
    //正式跳转
    
    
    //以xib_区分是否是storyboard构建的页面
    BaseViewController *vc;
    
    if ([name hasPrefix:@"xib_"]){
        vc = (BaseViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:[name substringFromIndex:4]];
    }else{
        vc = (BaseViewController *)[[NSClassFromString(name) alloc]init];
    }
    
    if (!vc) return NO;
    
    vc.routeParam = param;
    vc.hidesBottomBarWhenPushed = YES;
    if ([self.navigationController.topViewController isKindOfClass:NSClassFromString(name)]) {
        return NO;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    return YES;
}

- (void)openInSafari:(NSURL *)url{
    if([[UIApplication sharedApplication] canOpenURL:url]) {
         [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}


@end
