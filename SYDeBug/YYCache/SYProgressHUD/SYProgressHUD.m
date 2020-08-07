//
//  SYProgressHUD.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/6/19.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SYProgressHUD.h"
#import <MBProgressHUD.h>

@implementation SYProgressHUD


+ (void)progressMessage:(NSString *)message{
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow];
    if (hud == nil) {
        
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud = [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow];
        hud.label.text = message;
        
    }else {
        
        [hud showAnimated:YES];
    }
}

+ (void)progressView:(UIView *)view Message:(NSString *)message{
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (hud == nil) {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud = [MBProgressHUD HUDForView:view];
        hud.label.text = message;
    }else{
        
        [hud showAnimated:YES];
    }
}


+ (void)messageSuccess:(NSString *)message{
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow];
    if (hud == nil) {
        
//        UIImage *successImage = [[UIImage imageNamed:@"sytoast_success" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud = [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow];
//        hud.customView = [[UIImageView alloc] initWithImage:successImage];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.7];
        hud.mode = MBProgressHUDModeCustomView;
        hud.label.text = message;
        hud.label.textColor = [UIColor whiteColor];
        
    }else {
        [hud showAnimated:YES];
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5];
}


+ (void)messageError:(NSString *)message{
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow];
    
    if (hud == nil) {
        
//        UIImage *errorImage = [[UIImage imageNamed:@"sytoast_error" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud = [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow];
//        hud.customView = [[UIImageView alloc] initWithImage:errorImage];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.7];
        hud.mode = MBProgressHUDModeCustomView;
        hud.label.text = message;
        hud.label.textColor = [UIColor whiteColor];
        
    }else {
        [hud showAnimated:YES];
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5];
}


/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD {
    [SYProgressHUD hideHUDForView:nil];
}
/**
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *_Nullable)view {
    if (view == nil){
        view = [UIApplication sharedApplication].keyWindow;
    }
    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
