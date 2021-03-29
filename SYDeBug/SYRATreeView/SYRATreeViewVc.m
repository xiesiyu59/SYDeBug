//
//  SYRATreeViewVc.m
//  SYDeBug
//
//  Created by xiesiyu on 2021/3/29.
//  Copyright © 2021 xiesiyu. All rights reserved.
//

#import "SYRATreeViewVc.h"
#import "SYTreeViewCell.h"
#import <RATreeView.h>
#import "RaTreeModel.h"

@interface SYRATreeViewVc () <RATreeViewDataSource, RATreeViewDelegate>

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation SYRATreeViewVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithInitialization];
    [self initWithinitializationDataSource];
}

#pragma mark - <初始化界面>
- (void)initWithInitialization {
    
    RATreeView *ratreeView = [[RATreeView alloc] initWithFrame:CGRectZero style:RATreeViewStylePlain];
    ratreeView.separatorStyle = RATreeViewCellSeparatorStyleNone;
    ratreeView.backgroundColor = [UIColor whiteColor];
    ratreeView.delegate = self;
    ratreeView.dataSource = self;
    
    [self.view addSubview:ratreeView];
    [ratreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    
}

#pragma mark - <初始化数据源>
- (void)initWithinitializationDataSource {
    
    //宝鸡市 (四层)
    RaTreeModel *zijingcun = [RaTreeModel dataObjectWithName:@"紫荆村" children:nil];
    RaTreeModel *chengcunzheng = [RaTreeModel dataObjectWithName:@"陈村镇" children:@[zijingcun]];
    RaTreeModel *fengxiang = [RaTreeModel dataObjectWithName:@"凤翔县" children:@[chengcunzheng]];
    RaTreeModel *qishan = [RaTreeModel dataObjectWithName:@"岐山县" children:nil];
    RaTreeModel *baoji = [RaTreeModel dataObjectWithName:@"宝鸡市" children:@[fengxiang,qishan]];
    //西安市
    RaTreeModel *yantaqu = [RaTreeModel dataObjectWithName:@"雁塔区" children:nil];
    RaTreeModel *xinchengqu = [RaTreeModel dataObjectWithName:@"新城区" children:nil];
    RaTreeModel *xian = [RaTreeModel dataObjectWithName:@"西安" children:@[yantaqu,xinchengqu]];
    RaTreeModel *shanxi = [RaTreeModel dataObjectWithName:@"陕西" children:@[baoji,xian]];
    
    self.modelArray = [NSMutableArray array];
    [self.modelArray addObject:shanxi];
}


#pragma mark -----------delegate
//返回行高
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item {
    return 50;
}

//将要展开
- (void)treeView:(RATreeView *)treeView willExpandRowForItem:(id)item {
    SYTreeViewCell *cell = (SYTreeViewCell *)[treeView cellForItem:item];
    cell.iconView.backgroundColor = [UIColor orangeColor];
}
//将要收缩
- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item {
    SYTreeViewCell *cell = (SYTreeViewCell *)[treeView cellForItem:item];
    cell.iconView.backgroundColor = [UIColor redColor];
}
//已经展开
- (void)treeView:(RATreeView *)treeView didExpandRowForItem:(id)item {
    NSLog(@"已经展开了");
}
//已经收缩
- (void)treeView:(RATreeView *)treeView didCollapseRowForItem:(id)item {
    NSLog(@"已经收缩了");
}
  
//# dataSource方法
//返回cell
- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item {
    //获取cell
    SYTreeViewCell *cell = [SYTreeViewCell treeViewCellWith:treeView];
    //当前层级
    NSInteger level = [treeView levelForCellForItem:item];
    //当前item
    RaTreeModel *model = item;
    model.treeDepthLevel = level;
    //赋值
    [cell syTreeViewCellWithModel:model level:level children:model.children.count];
    return cell;
}
/**
 *  必须实现
 *
 *  @param treeView treeView
 *  @param item    节点对应的item
 *
 *  @return  每一节点对应的个数
 */
- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item {
    
    RaTreeModel *model = item;
    if (item == nil) {
        return self.modelArray.count;
    }
    return model.children.count;
}
/**
 *必须实现的dataSource方法
 *
 *  @param treeView treeView
 *  @param index    子节点的索引
 *  @param item     子节点索引对应的item
 *
 *  @return 返回 节点对应的item
 */
- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item {
    RaTreeModel *model = item;
    if (item==nil) {
        return self.modelArray[index];
    }
    return model.children[index];
}
//cell的点击方法
- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item {
    //获取当前的层
    NSInteger level = [treeView levelForCellForItem:item];
    //当前点击的model
    RaTreeModel *model = item;
    if (model.isOpen) {
        model.isOpen = NO;
    }else{
        model.isOpen = YES;
    }
    NSLog(@"点击的是第%ld层,name=%@",level,model.name);
}
//单元格是否可以编辑 默认是YES
- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item {
    return YES;
}
//编辑要实现的方法
- (void)treeView:(RATreeView *)treeView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowForItem:(id)item {
    NSLog(@"编辑了实现的方法");
}

@end
