//
//  XibViewController.m
//  SYDeBug
//
//  Created by xiesiyu on 2019/10/29.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "XibViewController.h"
#import "XibTableViewCell.h"
#import "SYProgressHUD.h"

static NSString *identifier = @"cell";

@interface XibViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *xsyTableView;

@end

@implementation XibViewController

- (BOOL)sy_interactivePopDisabled{
    return YES;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"xib控制器";
    
    self.dataArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@""]];
    
    self.xsyTableView.delegate = self;
    self.xsyTableView.dataSource = self;
    self.xsyTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.xsyTableView registerNib:[UINib nibWithNibName:@"XibTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    
}

#pragma mark -- <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XibTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


//Head
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

//Footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}


- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath {
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath {

    return @"删除";
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.xsyTableView beginUpdates];
       
        [self.dataArray removeObjectAtIndex:indexPath.section];
        [self.xsyTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        [self.xsyTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        [self.xsyTableView endUpdates];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.xsyTableView reloadData];
        });
    }
}

//- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    TIMConversation *conv = self.sourceArray[indexPath.row];
//
//    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//        [self.tableView setEditing:NO animated:YES];// 这句很重要，退出编辑模式，隐藏左滑菜单
//        [self.sourceArray removeObjectAtIndex:indexPath.row];
////        [[TIMManager sharedInstance] deleteConversation:conv.getType receiver:conv.getReceiver];
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        [self.tableView reloadData];
//    }];
//    deleteAction.backgroundColor = [UIColor redColor];
//    UISwipeActionsConfiguration *actions = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
//    actions.performsFirstActionWithFullSwipe = NO;
//    return actions;
//}


//自定义多个左滑菜单选项
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction;
    deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [tableView setEditing:NO animated:YES];//退出编辑模式，隐藏左滑菜单
        [SYProgressHUD messageSuccess:@"删除"];
        
    }];
    if (indexPath.row == 1) {//在不同的cell上添加不同的按钮
        UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"分享" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            [tableView setEditing:NO animated:YES];//退出编辑模式，隐藏左滑菜单
            [SYProgressHUD messageSuccess:@"分享"];
        }];
        shareAction.backgroundColor = [UIColor blueColor];
        return @[deleteAction,shareAction];
    }
    return @[deleteAction];
}



@end
