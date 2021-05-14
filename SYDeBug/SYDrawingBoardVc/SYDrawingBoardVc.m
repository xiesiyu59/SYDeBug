//
//  SYDrawingBoardVc.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/5/12.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYDrawingBoardVc.h"
#import "SYDrawingBoardView.h"
#import "SYDrawingBoardToolView.h"
#import "SYDrawingBoardColorView.h"

@interface SYDrawingBoardVc () <SYDrawingBoardToolViewDelegate,SYDrawingBoardColorViewDelegate>

@property (nonatomic, strong)SYDrawingBoardView *drawingBoardView;                //画板
@property (nonatomic, strong)SYDrawingBoardToolView *drawingBoardToolView;        //工具栏
@property (nonatomic, strong)SYDrawingBoardColorView *drawingBoardColorView;      //画笔颜色


@end

@implementation SYDrawingBoardVc

- (BOOL)sy_preferredNavigationBarHidden{
    return YES;
}

- (BOOL)sy_interactivePopDisabled{
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat toolHeight = 80;
    //画布
    self.drawingBoardView = [[SYDrawingBoardView alloc] init];
    [self.view addSubview:self.drawingBoardView];
    [self.drawingBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, toolHeight, 0));
    }];
    
    //工具栏
    self.drawingBoardToolView = [[SYDrawingBoardToolView alloc] init];
    self.drawingBoardToolView.delegate = self;
    [self.view addSubview:self.drawingBoardToolView];
    [self.drawingBoardToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(toolHeight);
    }];
    
    //画笔颜色
    self.drawingBoardColorView = [[SYDrawingBoardColorView alloc] initWithFrame:self.view.bounds];
    self.drawingBoardColorView.delegate = self;
}


#pragma mark - <SYDrawingBoardToolViewDelegate>
- (void)didToolBtn:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            //清除
            [self.drawingBoardView clean];
        }break;
        case 1:{
            //撤销
            [self.drawingBoardView undo];
        }break;
        case 2:{
            //恢复
            [self.drawingBoardView redo];
        }break;
        case 3:{
            //画笔
            [self.drawingBoardColorView showOnWindow];
        }break;
        case 4:{
            //橡皮檫
            [self.drawingBoardView eraser];
        }break;
        case 5:{
            //保存
            [self showAlertViewTitle:@"" Completed:^{
                [self.drawingBoardView save];
            }];
        }break;
            
        default:break;
    }
    
}

- (void)lineWidth:(CGFloat)lineWidth{
    
    self.drawingBoardView.lineWidth = lineWidth;
}

#pragma mark - <SYDrawingBoardColorViewDelegate>
- (void)drawingBoardColor:(UIColor *)color{
    
    self.drawingBoardToolView.slider.tintColor = color;
    self.drawingBoardView.lineColor = color;
}

- (void)showAlertViewTitle:(NSString *)title Completed:(void (^)(void))completed{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存或者退出" message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        if (completed) {
            completed();
        }
    }];
    
    [alert addAction:okAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:cancelAction];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}


@end
