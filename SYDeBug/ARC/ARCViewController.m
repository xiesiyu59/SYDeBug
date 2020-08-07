//
//  ARCViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2020/5/26.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "ARCViewController.h"
#import "LabelView.h"
#import "AdModel.h"
#import "MainModel.h"
#import "SpecialModel.h"
#import "LabelViewModel.h"
#import "HTTPSessionManager.h"

@interface ARCViewController ()

@property (nonatomic, strong)LabelView *labelView;

@end

@implementation ARCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ARC";
    [self initWithInitialization];
    [self initWithinitializationDataSource];
    
}

#pragma mark - <初始化数据源>
- (void)initWithinitializationDataSource {
    
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [[HTTPSessionManager shareManager] POST:@"others/v1/ad" parameters:@{} callBack:^(RespondModel * _Nonnull responseModel) {
            if (responseModel.code == RespondCodeSuccess) {
                
                NSArray *array = responseModel.data;
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSDictionary *dict in array) {
                    AdModel *model = [AdModel modelWithDictionary:dict];
                    [tempArray addObject:model];
                }
                [subscriber sendNext:tempArray];
                
            }else if (responseModel.code == RespondCodeError || responseModel.code == RespondCodeNotJson){
                [subscriber sendNext:responseModel.msg];
            }
        }];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [[HTTPSessionManager shareManager] POST:@"others/v1/information/main" parameters:@{} callBack:^(RespondModel * _Nonnull responseModel) {
            if (responseModel.code == RespondCodeSuccess) {
                NSArray *array = responseModel.data;
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSDictionary *dict in array) {
                    MainModel *model = [MainModel modelWithDictionary:dict];
                    [tempArray addObject:model];
                }
                [subscriber sendNext:tempArray];
                
            }else if (responseModel.code == RespondCodeError || responseModel.code == RespondCodeNotJson){
                [subscriber sendNext:responseModel.msg];
            }
        }];

        return nil;
        
    }];
    
    RACSignal *signal3 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [[HTTPSessionManager shareManager] POST:@"others/v1/special" parameters:@{} callBack:^(RespondModel * _Nonnull responseModel) {
            if (responseModel.code == RespondCodeSuccess) {
                
                NSArray *array = responseModel.data;
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSDictionary *dict in array) {
                    SpecialModel *model = [SpecialModel modelWithDictionary:dict];
                    [tempArray addObject:model];
                }
                [subscriber sendNext:tempArray];
                
            }else if (responseModel.code == RespondCodeError || responseModel.code == RespondCodeNotJson){
                [subscriber sendNext:responseModel.msg];
            }
        }];
        return nil;
        
    }];
    
    [self rac_liftSelector:@selector(refeshUI:two:three:) withSignals:signal1,signal2,signal3,nil];
    
}

- (void)refeshUI:(id)one two:(id)two three:(id)three{
    
    NSLog(@"%@---%@---%@",one,two,three);
    [self.labelView adArray:one];
    [self.labelView mainArray:two];
    [self.labelView specialArray:three];
    
}


#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"点击" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScreenTopIsX);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    [[leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         NSLog(@"-->%@",x);
    }];
    
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5"];
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"内容-->%@", x);
    }];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"读取" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor orangeColor];
    [rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScreenTopIsX);
        make.left.equalTo(leftButton.mas_right);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    
    self.labelView = [[LabelView alloc] init];
    [self.view addSubview:self.labelView];
    [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightButton.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
}


- (void)buttonClick:(UIButton *)sender{
    
    NSLog(@"点击了");
    
}

@end
