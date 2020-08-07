//
//  FMDBVc.m
//  SYDeBug
//
//  Created by xiesiyu on 2019/11/12.
//  Copyright © 2019 xiesiyu. All rights reserved.
//

#import "FMDBVc.h"
#import "InfoModel.h"
#import "FMDBManager.h"
#import "StudentCell.h"

static NSString *identifier = @"cell";

@interface FMDBVc () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *xsyTableView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation FMDBVc

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FMDB";
    [self initWithInitialization];
    //查询表
    [self resultSet];
    
//    [[FMDBManager shareManager] editColumnName];
    
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithTitle:@"删除表" style:(UIBarButtonItemStylePlain) target:self action:@selector(deleteItemText)];
    [deleteItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor redColor]} forState:(UIControlStateNormal)];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:(UIBarButtonItemStylePlain) target:self action:@selector(addItemText)];
    [addItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor blackColor]} forState:(UIControlStateNormal)];
    
    
    self.navigationItem.rightBarButtonItems = @[deleteItem,addItem];
    
}


- (void)deleteItemText{
    //删除表
    [self deleteTable];
    [self resultSet];
}

- (void)addItemText{
    //添加
    [self addInfo];
    [self resultSet];
}

#pragma mark - <初始化数据源>
- (void)initWithinitializationDataSource {
    
    
}

#pragma mark - <初始化界面>

- (void)initWithInitialization {
    
    self.xsyTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.xsyTableView.delegate = self;
    self.xsyTableView.dataSource = self;
    
    self.xsyTableView.tableFooterView = [UIView new];
    [self.xsyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    [self.xsyTableView registerNib:[UINib nibWithNibName:@"StudentCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.xsyTableView];
    [self.xsyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -- <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StudentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    InfoModel *model = self.dataArray[indexPath.row];
    cell.studentLabel.text = [NSString stringWithFormat:@"学号:%@\n名字:%@\n电话:%@\n分数:%@\n生日:%@",model.studentId,model.name,model.phone,model.score,model.brithday];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InfoModel *model = self.dataArray[indexPath.row];
    [self showAlertViewTitle:@"是否修改" editInfo:model Completed:^(InfoModel *info) {
        [self editInfo:model.userId edit:info];
        [self resultSet];
    }];
    
}

- (void)showAlertViewTitle:(NSString *)title editInfo:(InfoModel *)model Completed:(void (^)(InfoModel *info))completed{
    
    InfoModel *editModel = model;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
  
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"修改学号";
        
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"修改姓名";
        
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"修改电话";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"修改分数";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"修改生日";
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        
        editModel.studentId = [alert.textFields[0].text isEqualToString:@""]?model.studentId:alert.textFields[0].text;
        editModel.name = [alert.textFields[1].text isEqualToString:@""]?model.name:alert.textFields[1].text;
        editModel.phone = [alert.textFields[2].text isEqualToString:@""]?model.phone:alert.textFields[2].text;
        editModel.score =[alert.textFields[3].text isEqualToString:@""]?model.score:alert.textFields[3].text;
        editModel.brithday =[alert.textFields[4].text isEqualToString:@""]?model.brithday:alert.textFields[4].text;
        
        if (completed) {
            completed(editModel);
        }
    }];
    [okAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [alert addAction:okAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    }];
    [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    [alert addAction:cancelAction];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark ---- 侧滑删除
// 点击了“左滑出现的Delete按钮”会调用这个方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InfoModel *model = self.dataArray[indexPath.row];
    [self deleteInfo:model.userId];
    
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.xsyTableView reloadData];
    
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

// 修改Delete按钮文字为“删除”
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - <FMDB>
- (void)resultSet{
    
    [[FMDBManager shareManager] initialization];
    
    FMResultSet * resultSet = [[FMDBManager shareManager].db executeQuery:@"SELECT * FROM t_student ORDER BY studentId"];
    //根据条件查询
    //FMResultSet * resultSet = [fmdb executeQuery:@"select * from t_student where id < ?", @(4)];
    //遍历结果集合
    //添加后置空
    self.dataArray = nil;
    
    while ([resultSet next]) {
        
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
        
        int idNum = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet objectForColumn:@"name"];
        NSString *phone = [resultSet objectForColumn:@"phone"];
        NSString *score = [resultSet objectForColumn:@"score"];
        NSString *stuId = [resultSet objectForColumn:@"studentId"];
        NSString *brithday = [resultSet objectForColumn:@"brithday"];
        
        //组装
        [tempDict setValue:@(idNum) forKey:@"id"];
        [tempDict setValue:name forKey:@"name"];
        [tempDict setValue:phone forKey:@"phone"];
        [tempDict setValue:score forKey:@"score"];
        [tempDict setValue:stuId forKey:@"studentId"];
        [tempDict setValue:brithday forKey:@"brithday"];
        
        InfoModel *model = [[InfoModel alloc] initWithDict:tempDict];
        
        [self.dataArray addObject:model];
    }
    
    [self.xsyTableView reloadData];
//    NSLog(@"学号：%@ 姓名：%@ 手机号：%@ 分数：%@",@(idNum),name,phone,score);
    NSLog(@"%@",self.dataArray);
}

- (void)createTable{
    
    [[FMDBManager shareManager] initialization];
    //创建表
    //4.数据库中创建表（可创建多张）
    NSString *sql = @"CREATE TABLE IF NOT EXISTS t_student ('id' INTEGER PRIMARY KEY AUTOINCREMENT,'studentId' INTEGER NOT NULL,'name' TEXT NOT NULL, 'phone' TEXT NOT NULL,'score' INTEGER NOT NULL, 'brithday' TEXT NOT NULL)";
    //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
    BOOL result = [[FMDBManager shareManager].db executeUpdate:sql];
    if (result) {
        NSLog(@"create table success");
    }
    [[FMDBManager shareManager].db close];
    
}

- (void)addInfo{
    
    [self createTable];
    
    [[FMDBManager shareManager] initialization];
    //事务
    [[FMDBManager shareManager].db beginTransaction];
    BOOL rollBack = NO;
    @try {
        NSString *name = @"小小鱼";
        NSString *phone = @"13537118222";
        NSString *score = @"97";
        NSString *stutId = @"0001";
        NSString *brithday = @"";
        
        BOOL results = [[FMDBManager shareManager].db executeUpdate:@"INSERT INTO t_student (name, phone, score,studentId,brithday) VALUES (?,?,?,?,?)",name,phone,score,stutId,brithday];
        //    BOOL result = [fmdb executeUpdateWithFormat:@"insert into t_student (name,age, sex) values (%@,%i,%@)",name,age,sex];
        //3.参数是数组的使用方式
        //    BOOL result = [fmdb executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES  (?,?,?);" withArgumentsInArray:@[name,@(age),sex]];
        if (results) {
            NSLog(@"插入成功");
            
        } else {
            NSLog(@"插入失败");
        }
    } @catch (NSException *exception) {
        rollBack = NO;
        [[FMDBManager shareManager].db rollback];
    } @finally {
        rollBack = NO;
        [[FMDBManager shareManager].db commit];
    }
    
}

- (void)deleteTable{
    
    [[FMDBManager shareManager] initialization];
    
    BOOL result = [[FMDBManager shareManager].db executeUpdate:@"DROP TABLE IF EXISTS t_student"];
    if (result) {
        NSLog(@"删除表成功");
    } else {
        NSLog(@"删除表失败");
    }
}


- (void)editInfo:(NSString *)editId edit:(InfoModel *)model{
    
    [[FMDBManager shareManager] initialization];
    BOOL update = [[FMDBManager shareManager].db executeUpdate:@"UPDATE t_student SET name = ?,phone = ?, score = ? ,studentId = ?, brithday = ? WHERE id = ?",model.name,model.phone,model.score,model.studentId,model.brithday,editId];
    if (update) {
        NSLog(@"修改成功");
    } else {
        NSLog(@"修改失败");
    }
}

- (void)deleteInfo:(NSString *)deleteId{
    
    [[FMDBManager shareManager] initialization];
    BOOL deleate=[[FMDBManager shareManager].db executeUpdate:@"DELETE FROM t_student WHERE id = ?",deleteId];//按照id进行删除
    //    BOOL deleate=[fmdb executeUpdateWithFormat:@"delete from t_student where name = %@",@"王子涵1"];//按照名字进行删除
    if (deleate) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
}


- (void)dealloc{
    [[FMDBManager shareManager].db close];
}


@end
