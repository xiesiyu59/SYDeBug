//
//  SystemPhotoDetailViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/11/27.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SystemPhotoDetailViewController.h"

@interface SystemPhotoDetailViewController ()

@end

@implementation SystemPhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *lookImageView = [[UIImageView alloc] init];
    [lookImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:self.photoImage];
    [self.view addSubview:lookImageView];
    [lookImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
}


@end
