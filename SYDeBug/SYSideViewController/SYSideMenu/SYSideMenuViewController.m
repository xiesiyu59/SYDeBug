//
//  SYSideMenuViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/2/1.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYSideMenuViewController.h"


typedef NS_ENUM(NSInteger, SYOrientationState){
    SYSideMenuNoneState = 0,
    SYideMenuLeftState,
    SYideMenuRightState
};

typedef NS_ENUM(NSInteger, SYSideModel){
    SYSideMenuNoneModel = 0,
    SYSideMenuLeftModel,
    SYSideMenuRightModel
};

#define DefaultLeftVisibleOffset (kScreenWidth-80)

#define LEFT_TAG   100
#define CENTER_TAG 101

@interface SYSideMenuViewController (){
    
    UIView *_coverView;
    UIVisualEffectView *_visualEfView;
    UIPanGestureRecognizer *_panGestureRecognizer;
    CGFloat _startPointX;
    SYOrientationState _currentState;
    SYSideModel _currentModel;
}

@end

@implementation SYSideMenuViewController

- (SYSideMenuViewController *)initWithContentViewController:(UIViewController *)contentViewController leftSideViewController:(UIViewController *)leftSideViewController {
    
    self = [super init];
    if (self) {
        _centerViewController = contentViewController;
        _leftSideViewController = leftSideViewController;
        _leftVisibleOffset = DefaultLeftVisibleOffset;
        self.showAble = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubView];
    
    if (_leftSideViewController) {
        [self addChildViewController:_leftSideViewController];
    }
    
    [self configFrame];
    
    _currentState = SYSideMenuNoneState;
    _currentModel = SYSideMenuNoneModel;
    
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    [self.view addGestureRecognizer:_panGestureRecognizer];
}


- (void)addCoverView{
    if(!_coverView && !_visualEfView){
        _coverView = [[UIView alloc] initWithFrame:self.view.frame];
        _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6f];
//        _visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//        _visualEfView.frame = _coverView.frame;
//        _visualEfView.alpha = 1.0f;
//        _coverView.alpha = 0.0f;
        [_coverView addSubview:_visualEfView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAll)];
        [_coverView addGestureRecognizer:tap];
        [self.view addSubview:_coverView];
    }
}

- (void)removeCoverView{
    
    self.isLeftShow = NO;
    self.isRightShow = NO;
    _coverView.hidden = YES;
    _visualEfView = nil;
    _coverView = nil;
    _currentModel = SYSideMenuNoneModel;
    [_visualEfView removeFromSuperview];
    [_coverView removeFromSuperview];
    [_leftSideViewController.view removeFromSuperview];
}

- (void)configSubView{
    [self addChildViewController:_centerViewController];
    [self.view addSubview:_centerViewController.view];
}

- (void)configFrame{
    
    _centerViewController.view.frame = self.view.frame;
    _leftSideViewController.view.frame = self.view.frame;
    CGPoint leftInitCenter = CGPointMake(-kScreenWidth/2, kScreenHeight/2);
    _leftSideViewController.view.center = leftInitCenter;

}

- (void)setCenterViewController:(UIViewController *)centerViewController {
    
    _centerViewController = nil;
    _centerViewController = centerViewController;
    [[self.view viewWithTag:CENTER_TAG] removeFromSuperview];
    _centerViewController.view.frame = self.view.frame;
    centerViewController.view.tag = CENTER_TAG;
    
    [self.view addSubview:centerViewController.view];
    [self.view sendSubviewToBack:centerViewController.view];
    [self.view setNeedsLayout];
}

- (void)showLeftSideMenu {
    
    [self addCoverView];
    self.isLeftShow = YES;
    [self leftAnimate:YES];
}


- (void)leftAnimate:(BOOL)closeOrOpen{
    if (!_leftSideViewController) {
        return;
    }
    if(![self.view viewWithTag:LEFT_TAG]){
        [self.view addSubview:_leftSideViewController.view];
    }
    
    self.isLeftShow = closeOrOpen;
    _currentModel = closeOrOpen?SYSideMenuLeftModel:SYSideMenuNoneModel;
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGPoint center;
        if(closeOrOpen){
            self->_coverView.alpha = 1.0f;
            center = CGPointMake(DefaultLeftVisibleOffset - kScreenWidth/2, kScreenHeight/2);
        }else{
            self->_coverView.alpha = 0.0f;
            center = CGPointMake(-kScreenWidth/2, kScreenHeight/2);
        }
        
        self->_leftSideViewController.view.center = center;
    } completion:^(BOOL finished) {
        
        if(!closeOrOpen){
            [self removeCoverView];
        }
        self->_currentState = SYSideMenuNoneState;
    }];
}

- (void)hiddenAll {
    
    self.isLeftShow = NO;
    
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self->_coverView.alpha = 0.0f;
        CGPoint leftCenter = CGPointMake(-kScreenWidth/2, kScreenHeight/2);
        self->_leftSideViewController.view.center = leftCenter;
        
    } completion:^(BOOL finished) {
        [self removeCoverView];
    }];
}

- (void)leftSideChangeWithXOffset:(CGFloat)pointX withAlphaValue:(CGFloat)alphaValue {
    
    [self addCoverView];
    if (!_leftSideViewController) {
        return;
    }
    if(![self.view viewWithTag:LEFT_TAG]){
        [self.view addSubview:_leftSideViewController.view];
    }
    self.isLeftShow = YES;
    _coverView.alpha = alphaValue;
    CGPoint leftCenter = CGPointMake(pointX, kScreenHeight/2);
    NSLog(@"%f",leftCenter.x);
    if (leftCenter.x > (kScreenWidth == 375?107:127)) {
        leftCenter.x = kScreenWidth == 375?107:127;
    }
    _leftSideViewController.view.center = leftCenter;
}


- (BOOL)judgePanWithModel:(SYSideModel)model {
    
    BOOL judgeResult = NO;
    if(model == SYSideMenuLeftModel){
        if (_leftSideViewController.view.center.x > _leftVisibleOffset-kScreenWidth/2) {
            judgeResult = NO;
        }else{
            judgeResult = YES;
        }
    }
    return judgeResult;
}


- (void)handleSwipes:(UIPanGestureRecognizer *)sender {
    
    if (!self.showAble) {
        return;
    }
    CGPoint point = [sender locationInView:self.view];
    CGFloat tempPointX = point.x;
    CGFloat tempX = tempPointX-_startPointX;
    CGFloat tempAlpha = fabs(tempX/DefaultLeftVisibleOffset);
    
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:{
            _startPointX = tempPointX;
        }break;
        case UIGestureRecognizerStateChanged:{
            if(_currentState != SYSideMenuNoneState){
                if(_currentModel == SYSideMenuNoneModel){
                    if(_currentState == SYideMenuLeftState){
                        [self leftSideChangeWithXOffset:(-kScreenWidth/2 + tempX) withAlphaValue:tempAlpha];
                    }
                }else if (_currentModel == SYSideMenuLeftModel){
                    if([self judgePanWithModel:_currentModel]){
                        [self leftSideChangeWithXOffset:(DefaultLeftVisibleOffset - kScreenWidth/2 + tempX) withAlphaValue:1.0f - tempAlpha];
                    }
                }
                
            }else{
                if (tempPointX - _startPointX > 0.01f) {
                    //从左边划起
                    if (_currentModel != SYSideMenuLeftModel) {
                        _currentState = SYideMenuLeftState;
                    }
                }
                
                if (tempPointX - _startPointX < 0.01f) {
                    //从右划起
                    if (_currentModel != SYSideMenuRightModel) {
                        _currentState = SYideMenuRightState;
                    }
                }
            }
            
        }break;
        case UIGestureRecognizerStateEnded:{
            [self gestureRecognizerStateEndAndCancle:tempX];
        }break;
        case UIGestureRecognizerStateCancelled:{
            [self gestureRecognizerStateEndAndCancle:tempX];
        }break;
        default:break;
    }
}

- (void)gestureRecognizerStateEndAndCancle:(CGFloat)tempX {
    
    if(_currentModel == SYSideMenuNoneModel){
        if(_currentState == SYideMenuLeftState){
            if(tempX >= 50.0f){
                [self leftAnimate:YES];
            }else{
                [self leftAnimate:NO];
            }
        }
    }else if (_currentModel == SYSideMenuLeftModel){
        if (_currentState != SYSideMenuNoneState) {
            if(tempX <= -50.0f){
                [self leftAnimate:NO];
            }else{
                [self leftAnimate:YES];
            }
        }
    }
    
    _currentState = SYSideMenuNoneState;
}

@end
