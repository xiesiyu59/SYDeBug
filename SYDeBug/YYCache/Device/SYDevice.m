//
//  SYDevice.m
//  UrumqiMetro
//
//  Created by xiesiyu on 2019/5/13.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "SYDevice.h"


@implementation SYDevice

+ (BOOL)isPhoneX {
    
    if ([[UIApplication sharedApplication] statusBarFrame].size.height > 20) {
        return YES;
    }
    return NO;
}

//系统提示框
+ (void)showAlertViewTitle:(NSString *)title {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [[UIViewController getCurrentVC] presentViewController:alert animated:YES completion:nil];
}

+ (void)showAlertViewTitle:(NSString *)title completed:(void (^)(void))completed{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        if (completed) {
            completed();
        }
    }];
    [okAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [alert addAction:okAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    }];
    [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [alert addAction:cancelAction];
    
    [[UIViewController getCurrentVC] presentViewController:alert animated:YES completion:nil];
    
}


@end
