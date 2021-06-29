//
//  SJPlayerViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/6/21.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SJPlayerViewController.h"
#import <SJVideoPlayer/SJVideoPlayer.h>

@interface SJPlayerViewController ()

@property (nonatomic, strong, readonly) SJVideoPlayer *player;

@end

@implementation SJPlayerViewController

- (BOOL)sy_preferredNavigationBarHidden{
    return YES;
}


- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_player vc_viewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_player vc_viewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_player vc_viewDidDisappear];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
    
    _player = SJVideoPlayer.player;
    [self.view addSubview:_player.view];
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.offset(0);
        make.height.equalTo(self.player.view.mas_width).multipliedBy(9/16.0);
    }];
    
    
    SJVideoPlayerURLAsset *asset = [SJVideoPlayerURLAsset.alloc initWithURL:[NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"] startPosition:0];
    _player.URLAsset = asset;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
