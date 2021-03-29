//
//  MakeAQuestionViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/3/3.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "MakeAQuestionViewController.h"

@interface MakeAQuestionViewController ()

@end

@implementation MakeAQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self str1Str2];
    
    
}

//计算一个字符串在另一个字符串中出现的次数
- (void)str1Str2{
    
    
    NSString *str1 = @"牛逼谢思宇哈谢思宇哈谢思宇哈哈谢思哈哈谢哈哈谢思宇思宇宇谢思宇谢思宇谢思宇";
    NSString *str2 = @"谢思宇";
    NSInteger count = 0;
    
    do {
        
        NSRange tempRange = [str1 rangeOfString:str2];
        NSLog(@"%zi-%zi",tempRange.location,tempRange.length);
        if (tempRange.location == NSNotFound) {
            break;
        }
        count++;
        str1 = [str1 substringFromIndex:tempRange.location+tempRange.length];
        if (!str1) {
            return;
        }
    } while (true);
    NSLog(@"%zi",count);
}



@end
