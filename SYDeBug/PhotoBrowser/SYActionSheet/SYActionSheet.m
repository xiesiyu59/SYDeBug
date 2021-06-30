//
//  SYActionSheet.m
//  Footstone
//
//  Created by xiesiyu on 2020/8/26.
//  Copyright © 2020 xiesiyu. All rights reserved.
//

#import "SYActionSheet.h"
#import <UIView+MJExtension.h>
#import "SYActionSheetCell.h"

@interface SYActionSheet ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray <NSString *> *options;
@property (nonatomic, strong) NSArray <NSString *> *imageOptions;
@property (nonatomic, copy  ) void (^selectedBlock)(NSInteger selectedIndex);
@property (nonatomic, strong) NSString *cancelTitle;
@property (nonatomic, copy  ) void (^cancelBlock)(void);

//@property (nonatomic, strong) UIWindow *overlayWindow;

@property (nonatomic, assign) NSInteger contentHeight;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SYActionSheet

+ (void)showWithTitle:(NSString *_Nullable)title
              options:(NSArray<NSString *> *)options
        selectedBlock:(void (^)(NSInteger))selectedBlock
          cancelTitle:(NSString *)cancelTitle
          cancelBlock:(void (^)(void))cancelBlock{
    SYActionSheet *actionSheet = [[SYActionSheet alloc]initWithFrame:[UIScreen mainScreen].bounds];
    actionSheet.title = title;
    actionSheet.options = options;
    actionSheet.selectedBlock = selectedBlock;
    actionSheet.cancelTitle = cancelTitle;
    actionSheet.cancelBlock = cancelBlock;
    [actionSheet showOnWindow];
}

+ (void)showWithTitle:(NSString *_Nullable)title
              options:(NSArray <NSString *>*)options
         imageOptions:(NSArray <NSString *>*)imageOptions
        selectedBlock:(void(^)(NSInteger selectedIndex))selectedBlock
          cancelTitle:(NSString *)cancelTitle
          cancelBlock:(void(^)(void))cancelBlock{
    
    SYActionSheet *actionSheet = [[SYActionSheet alloc]initWithFrame:[UIScreen mainScreen].bounds];
    actionSheet.title = title;
    actionSheet.options = options;
    actionSheet.imageOptions = imageOptions;
    actionSheet.selectedBlock = selectedBlock;
    actionSheet.cancelTitle = cancelTitle;
    actionSheet.cancelBlock = cancelBlock;
    [actionSheet showOnWindow];
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 1, 0, 1);
        self.tableView.separatorColor = [UIColor lightGrayColor];
        self.tableView.scrollEnabled = NO;
        self.tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:247/255.0 alpha:1.0/1.0];
        self.tableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tableView];
        self.tableView.transform = CGAffineTransformMakeTranslation(0, self.mj_h);
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.tableView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(12, 12)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.tableView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.tableView.layer.mask = maskLayer;
        
    }
    return self;
}

- (void)showOnWindow{

    self.contentHeight = (self.title ? 54 : 0) + self.options.count * 54 + 10 + 54 + kScreenBottomIsX;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.22 animations:^{
        self.tableView.transform = CGAffineTransformMakeTranslation(0, self.mj_h - self.contentHeight);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.6];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![touches.anyObject.view isDescendantOfView:self.tableView]) {
        [self hideFromWindowCompletedHandler:nil];
    }
}

- (void)hideFromWindowCompletedHandler:(void(^)(void))completedHandler{
    [UIView animateWithDuration:.22 animations:^{
        self.tableView.transform = CGAffineTransformMakeTranslation(0, self.mj_h);
    } completion:^(BOOL finished) {
        if (completedHandler) {
            completedHandler();
        }
        [self removeFromSuperview];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section ? 1 : self.options.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section) return [UIView new];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor =[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0/1.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    label.preferredMaxLayoutWidth = kScreenWidth/3.f*2;
    label.numberOfLines = 0;
    label.minimumScaleFactor = .5;
    label.adjustsFontSizeToFitWidth = YES;
    label.text = self.title;
    
    return label;
    return [UIView new];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!self.title) {
        return kOnePx;
    }
    return section ? kOnePx : 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section) {
        return CGFLOAT_MIN;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:247/255.0 alpha:1.0/1.0];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 54;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor colorWithRed: 43/255.0 green: 44/255.0 blue: 46/255.0 alpha:1.0/1.0];
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    if (indexPath.section == 1) {
        cell.textLabel.text = self.cancelTitle?:@"取消";
    }else{
        
        if (self.imageOptions.count) {
            SYActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYActionSheetCell"];
            if (!cell) {
                cell = [[SYActionSheetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SYActionSheetCell"];
            }
            cell.titleLabel.text = self.options[indexPath.row];
            cell.iconImageView.image = IMG(self.imageOptions[indexPath.row]);
            return cell;
            
        }else{
            cell.textLabel.text = self.options[indexPath.row];
        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        if (self.cancelBlock) {
            [self hideFromWindowCompletedHandler:^{
                self.cancelBlock();
                self.cancelBlock = nil;
            }];
        }else{
            [self hideFromWindowCompletedHandler:nil];
        }
        
    }else{
        if (self.selectedBlock) {
            [self hideFromWindowCompletedHandler:^{
                self.selectedBlock(indexPath.row);
                self.selectedBlock = nil;
            }];
        }else{
            [self hideFromWindowCompletedHandler:nil];
        }
    }
}


- (void)dealloc{
    
    NSLog(@"deallloc");
}

@end
