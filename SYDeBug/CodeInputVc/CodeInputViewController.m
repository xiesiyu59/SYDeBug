//
//  CodeInputViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/1/25.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "CodeInputViewController.h"
#import "SYValidationCodeView.h"

@interface CodeInputViewController () <SYValidationCodeViewDelegate>

@end

@implementation CodeInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"框型验证输入";
    [self initWithInitialization];
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    NSInteger codeSpacing = 32;
    NSInteger codeCount = 4;
    
    SYValidationCodeView *view = [[SYValidationCodeView alloc] init];
    [view validationPropertySettingViewSpacing:codeSpacing codeCount:codeCount inputCodeColor:[UIColor redColor] waitCodeColor:[UIColor blackColor] delegate:self];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(kScreenTopIsX);
        make.width.equalTo(self.view);
        make.height.mas_equalTo((kScreenWidth-codeSpacing)/codeCount);
    }];
    
}

#pragma mark - <SYValidationCodeViewDelegate>
- (void)validationCodeViewInputCodes:(NSString *)codes{
    
    NSLog(@"%@",codes);
}


@end
